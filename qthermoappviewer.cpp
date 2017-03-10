#include "qthermoappviewer.h"
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
#include <QLocale>
#include <QMetaObject>
#include <QThread>

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

    connect(mainRec, SIGNAL(mainAppState(QString)),
            this, SLOT(appStateSignal(QString)));

    connect(mainRec, SIGNAL(captureThermostatEventInfo(QString, QString, qreal, qreal)),
            m_eventMonitor, SLOT(captureThermostatEventInfo(QString,QString,qreal,qreal)));

    connect(&oneSecondTick, SIGNAL(timeout()),
            this, SLOT(CheckIndoorCondition()));

    connect(&fiveSecondTick, SIGNAL(timeout()),
            this, SLOT(CheckOutsideTemp()));

    connect(&fiveSecondTick, SIGNAL(timeout()),
            this,SLOT(CheckIndoorTempRange()));

    connect(&oneMinuteTick, SIGNAL(timeout()),
            this, SLOT(logCurrentStatus()));

    connect(m_connection, SIGNAL(bytesWritten(qint64)),
            this,SLOT(checkWriteStatus(qint64)));


    m_eventMonitor->ReadThermoEvents();

    oneSecondTick.setInterval(1000);        // every second
    oneSecondTick.start();
    fiveSecondTick.setInterval(5000);       //  every 5 seconds
    fiveSecondTick.start();
    oneMinuteTick.setInterval(60*1000);     // every minute
    oneMinuteTick.start();
}

void qThermoAppViewer::appStateSignal(const QString& state)
{
    qDebug() << "Current App State:" << state;
    if(state == "MainWindowState") {
        qDebug() << "Correctly got to MainWindowState";
        QObject *mainWindowRectangle = rootObject()->findChild<QObject*>("mainWindowRectangle");
        mainWindowRectangle->setProperty("loTargetTemp", QVariant("65"));
        mainWindowRectangle->setProperty("hiTargetTemp", QVariant("87"));

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

void qThermoAppViewer::logCurrentStatus()
{
    thermostatData m_thermostatData;

    m_thermostatData.setIndoorTemp(currentIndoorTemp);
    m_thermostatData.setIndoorHumidity(currentIndoorHumidity);
    m_thermostatData.setThermostatRange(currentTempRange);
    m_thermostatData.setOutdoorTemp(m_weather->currentWeather().temperature());
    m_thermostatData.setTimestamp(QDateTime::currentDateTime());

    bytesToBeWritten = 0;
    bytesToBeWritten = m_thermostatData.dataPayloadSize();

//    ServerConnection *worker = new ServerConnection(this);
//    QThread *thread = new QThread(this);

//    worker->moveToThread(thread);

////    connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
////    connect(thread, SIGNAL (started()), worker, SLOT (process()));
//    connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
//    connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
//    connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
//    thread->start();
//    worker->sendThermoData(m_thermostatData);
}

void qThermoAppViewer::checkWriteStatus(qint64 bytes)
{
    bytesToBeWritten -= bytes;
    if(bytesToBeWritten <= 0) {
        m_connection->close();
    }
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

void qThermoAppViewer::CheckIndoorTempRange()
{
    QDateTime current = QDateTime::currentDateTime();
    QString day = current.toString("ddd").toUpper();
    QTime t = current.time();
    currentTempRange = m_eventMonitor->getTempRange(day,t);

    QVariant returnedValue;
    QVariant heatState;
    if(currentIndoorTemp < currentTempRange.first){
        // too cold, turn on the heat
        heatState = "heat";
        QMetaObject::invokeMethod(mainRec, "setHeatingState",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, heatState));

    } else if(currentIndoorTemp > currentTempRange.second) {
        // too hot, turn on the AC
        heatState = "cool";
        QMetaObject::invokeMethod(mainRec, "setHeatingState",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, heatState));
    } else {
        // all is good, do nothing
        heatState = "nothing";
        QMetaObject::invokeMethod(mainRec, "setHeatingState",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, heatState));
    }
}

void qThermoAppViewer::CheckOutsideTemp(void)
{
    mainRec->setProperty("outsideCurrentTemp",m_weather->niceTemperatureString(m_weather->weather()->temperature()));
    mainRec->setProperty("curTemp", m_weather->niceTemperatureString(currentIndoorTemp));
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
