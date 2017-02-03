#include "thermoeventmonitor.h"
#include <QDebug>
#include <QStringList>
#include <QStringListIterator>
#include <QFile>
#include <QFileInfo>
#include <QDataStream>
#include <QSortFilterProxyModel>

#define THERMO_GROUPNAME "ThermostatEvents"

thermoEventMonitor::thermoEventMonitor(QObject *parent) :
    QObject(parent)
{
}

thermoEventMonitor::~thermoEventMonitor()
{
    qDebug() << "Saving thermoEvents";
    SaveThermoEvents();
}

void thermoEventMonitor::setEventModel(thermostatEventModel *t)
{
//    if(m_eventModel != NULL)
//        m_eventModel.deleteLater();

//    m_eventModel = *t;
}

void thermoEventMonitor::connectEventModel(QDeclarativeContext *mainContext)
{
//    QSortFilterProxyModel proxy;
//    proxy.setSourceModel(&m_eventModel);
//    proxy.sort()
//    proxy.setSortRole(thermostatEventModel::TimeRole);
//    proxy.setFilterRole(thermostatEventModel::DayRole);
//    proxy.setDynamicSortFilter(true);
//    proxy.sort(0);
//    mainContext->setContextProperty("eventListModel", &proxy);
    mainContext->setContextProperty("eventListModel", &m_eventModel);
}

//thermostatEvent thermoEventMonitor::thermoEvent(int row)
//{
//    thermostatEvent ev;
//    return ev;
//}

void thermoEventMonitor::captureThermostatEventInfo( QString dayOfWeek, QString targetTime, qreal lowTemp, qreal hiTemp)
{
    qDebug() << "Correctly captured:" << dayOfWeek << targetTime <<
                lowTemp << hiTemp;
    AddThermoEvent(dayOfWeek,targetTime, lowTemp, hiTemp);
    qDebug() << "We have" << m_eventModel.rowCount(QModelIndex()) << "thermo events";
    SaveThermoEvents(); // write the thermoEvents to disk so that we preserve them in case of power failure
//    for(int i = 0; i < m_eventModel.rowCount(QModelIndex()); i++) {
//        thermostatEvent ev = m_eventModel.getData(i);
//        qDebug() << i << ":" << ev.eventDayOfWeek() << ev.eventTime() <<
//                    ev.eventLoTemp() << ev.eventHiTemp();
//    }
}

void thermoEventMonitor::AddThermoEvent(QString dayOfWeek, QString targetTime,
        qreal lowTemp, qreal hiTemp)
{
    QStringList weekList;
    if(dayOfWeek == "ALL") {
        weekList << "SUN" << "MON" << "TUE" << "WED" << "THU" << "FRI" << "SAT";
    } else if(dayOfWeek == "WKDY") {
        weekList << "MON" << "TUE" << "WED" << "THU" << "FRI";
    } else if(dayOfWeek == "WKND") {
        weekList << "SUN" << "SAT";
    } else {
        weekList << dayOfWeek;
    }

    QStringListIterator i(weekList);
    while(i.hasNext()) {
        thermostatEvent ev;
        ev.setEventDayOfWeek(i.next());
        ev.setEventTime(targetTime);
        ev.setEventLoTemp(lowTemp);
        ev.setEventHiTemp(hiTemp);
        qDebug() << "adding:" << ev.eventDayOfWeek() << ev.eventTime()
                 << ev.eventLoTemp() << ev.eventHiTemp();
        AddThermoEvent(ev);
        qDebug() << "Event count is now:" << m_eventModel.rowCount(QModelIndex());
    }
}

void thermoEventMonitor::AddThermoEvent( thermostatEvent &ev )
{
//    m_eventModel.insertRows(0, 1, QModelIndex());

//    QModelIndex index = m_eventModel.index(0,0,QModelIndex());
//    m_eventModel.setData(index, ev );
    m_eventModel.addThermostatEvent(ev);
}

void thermoEventMonitor::ReadThermoEvents(void)
{
//    QSettings settings;
//    settings.beginGroup(THERMO_GROUPNAME);

//    settings.endGroup();
    QString filename = "thermoEvents.txt";
    QFile file(filename);
    if(file.exists()) {
        qDebug() << "file exists";
        file.open(QIODevice::ReadOnly);
        QDataStream in(&file);
        qDebug() << "file size is:" << file.size();
        qDebug() << "is file at end?" << in.atEnd();
        while(!in.atEnd()) {
            thermostatEvent e;
            in >> e;
            m_eventModel.addThermostatEvent(e);
            qDebug() << "Event reads:" << e.eventDayOfWeek() << e.eventTime() << e.eventLoTemp() << e.eventHiTemp();
            qDebug() << "is file at end?" << in.atEnd();
        }
        file.close();
    } else {
        qDebug() << "file does not exist";
    }
}

void thermoEventMonitor::SaveThermoEvents(void)
{
//    QSettings settings;
//    settings.beginGroup(THERMO_GROUPNAME);
//    settings.endGroup();
    QString filename = "thermoEvents.txt";
    QFile file(filename);
    if(file.exists())
        file.remove();
    file.open(QIODevice::ReadWrite);
    QDataStream out(&file);
    for( int i = 0; i < m_eventModel.rowCount(QModelIndex()); i++) {
        out << m_eventModel.getData(i);
    }
    file.close();
}

qreal thermoEventMonitor::convertToKelvin(int temp, QString scale)
{
    qreal kelvin;
    if(scale == "C") {
        kelvin = (qreal)temp + 273.15;
    } else {
        kelvin = (((qreal)temp + 459.67) * (qreal)5) / (qreal)9;
    }
    return kelvin;
}
