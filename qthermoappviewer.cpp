#include "qthermoappviewer.h"
//#include "qeventlistwindow.h"
#include <QDebug>
#include <QVariant>
#include <QMetaObject>
#include <QMetaProperty>
#include <QString>
#include <QHash>
#include <QHashIterator>
#include <QObjectList>
#include <QListIterator>
#include <QGraphicsObject>
#include <QGraphicsItem>
#include <QDeclarativeEngine>
#include <QDeclarativeItem>
#include <QDeclarativeContext>
#include <QTimer>

//#include <QtQml/QQmlProperty>

qThermoAppViewer::qThermoAppViewer(QtQuick1ApplicationViewer *parent) :
    QtQuick1ApplicationViewer(parent)
{
    initializingApp = true;
}

void qThermoAppViewer::Init(void)
{
    mainRec = this->rootObject();

    m_weather = new WeatherNetworkConnection(this);
    m_eventMonitor = new thermoEventMonitor(this);

    connect(&secondaryTick, SIGNAL(timeout()),
            this, SLOT(CheckTemp()));

    connect(mainRec, SIGNAL(mainAppState(QString)),
            this, SLOT(appStateSignal(QString)));

    connect(mainRec, SIGNAL(captureThermostatEventInfo(QString, QString, qreal, qreal)),
            m_eventMonitor, SLOT(captureThermostatEventInfo(QString,QString,qreal,qreal)));

    connect(&mainTick, SIGNAL(timeout()),
            this, SLOT(CheckIndoorCondition()));


    m_eventMonitor->ReadThermoEvents();

    mainTick.setInterval(1000);
    mainTick.start();
    secondaryTick.setInterval(5000);
    secondaryTick.start();
}


void qThermoAppViewer::LaunchEventListWin(void)
{
//    qDebug() << "We're here!";
//    qEventListWindow *evWin = new qEventListWindow();
//    evWin->Init();
}

void qThermoAppViewer::appStateSignal(const QString& state)
{
    qDebug() << "Current App State:" << state;
    if(state == "MainWindowState") {
        qDebug() << "Correctly got to MainWindowState";

    } else if(state == "EventWindowState") {
        qDebug() << "Correctly got to EventWindowState";
        m_eventMonitor->connectEventModel(rootContext());
        QObject *eventWinChild = rootObject()->findChild<QObject*>("eventListWin");
        connect(eventWinChild, SIGNAL(clearList()),
                m_eventMonitor, SLOT(clearList()));
        connect(eventWinChild, SIGNAL(deleteItem(int)),
                m_eventMonitor, SLOT(deleteListItem(int)));

    } else if(state == "WeatherWindowState") {
        qDebug() << "Correctly got to WeatherWindowState";
    }
}

void qThermoAppViewer::LaunchWeatherWin(void)
{
    qDebug() << "We're here!";
}

void qThermoAppViewer::CheckIndoorCondition(void)
{
    float hum = 0.0;
    float temp = 0.0;
    int success = DHT_SUCCESS;

#ifdef Q_PROCESSOR_ARM_V6   // only run this code on the Raspberry Pi

    success = pi_dht_read(DHT22, 4, &hum, &temp);
    qDebug() << "return val:" << success;

    qDebug() << "Current indoor condition: Temperature:" << temp << "humidity:" << hum;

#endif

    if(success == DHT_SUCCESS) {
        currentIndoorTemp = temp + 273.15;      // convert to Kelvin
        currentIndoorHumidity = hum;
//        qDebug() << "logging conditions" << currentIndoorTemp << currentIndoorHumidity;
    }

}

void qThermoAppViewer::CheckTemp(void)
{
    mainRec->setProperty("outsideCurrentTemp",m_weather->niceTemperatureString(m_weather->weather()->temperature()));
    mainRec->setProperty("curTemp", m_weather->niceTemperatureString(currentIndoorTemp));
//    mainRec->setProperty("targetTemp", m_weather->niceTemperatureString(294.261,false));
    mainRec->setProperty("currentWeatherIcon", m_weather->weather()->weatherIcon());
    mainRec->setProperty("curHumidity", currentIndoorHumidity);

    WeatherData *today = m_weather->forecast()->at(0);
    WeatherData *tomorrow = m_weather->getWeatherForDay(1);
    WeatherData *nextDay = m_weather->getWeatherForDay(2);

    if(today != NULL) {
        mainRec->setProperty("todayHiTemp", m_weather->niceTemperatureString( today->tempMax() ));
        mainRec->setProperty("todayLoTemp", m_weather->niceTemperatureString(today->tempMin()) );
        mainRec->setProperty("todayName", QDateTime::fromString(today->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
        mainRec->setProperty("todayIcon", today->weatherIcon());
//        qDebug() << "Today's weather Icon is:" << today->weatherIcon();
    }

    if(tomorrow != NULL) {
        mainRec->setProperty("tomorrowHiTemp", m_weather->niceTemperatureString(tomorrow->tempMax()) );
        mainRec->setProperty("tomorrowLoTemp", m_weather->niceTemperatureString(tomorrow->tempMin()) );
        mainRec->setProperty("tomorrowIcon", tomorrow->weatherIcon() );
        mainRec->setProperty("tomorrowName", QDateTime::fromString(tomorrow->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
//        qDebug() << "tomorrow's weather Icon is:" << tomorrow->weatherIcon();
    }

    if(nextDay != NULL) {
        mainRec->setProperty("nextDayHiTemp", m_weather->niceTemperatureString(nextDay->tempMax()) );
        mainRec->setProperty("nextDayLoTemp", m_weather->niceTemperatureString(nextDay->tempMin()) );
        mainRec->setProperty("nextDayName", QDateTime::fromString(nextDay->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
        mainRec->setProperty("nextDayIcon", nextDay->weatherIcon() );
//        qDebug() << "nextDay's weather Icon is:" << nextDay->weatherIcon();
    }

    if(initializingApp) {
        mainRec->setProperty("state", "MainWindowState");
        initializingApp = false;
    }
}

QDeclarativeItem* qThermoAppViewer::FindItemByName(QList<QObject*> nodes, const QString& name)
{

    for(int i = 0; i < nodes.size(); i++){
        // search for node
        if (nodes.at(i) && nodes.at(i)->objectName() == name){
            qDebug() << "found it at:"  << i << nodes.at(i)->objectName();
            return dynamic_cast<QDeclarativeItem*>(nodes.at(i));
        }
        // search in children
        else if (nodes.at(i) && nodes.at(i)->children().size() > 0){
            QDeclarativeItem* item = FindItemByName(nodes.at(i)->children(), name);
            if (item)
                qDebug() << "found it at:"  << i << nodes.at(i)->objectName();
                return item;
        }
        qDebug() << i;
    }
    // not found
    return NULL;
}
