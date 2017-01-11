#include "thermoeventmonitor.h"
#include <QDebug>
#include <QStringList>
#include <QStringListIterator>

#define THERMO_GROUPNAME "ThermostatEvents"

thermoEventMonitor::thermoEventMonitor(QObject *parent) :
    QObject(parent)
{
    m_eventModel = new thermostatEventModel(this);
}

void thermoEventMonitor::setEventModel(thermostatEventModel *t)
{
    if(m_eventModel != NULL)
        m_eventModel->deleteLater();

    m_eventModel = t;
}

//thermostatEvent thermoEventMonitor::thermoEvent(int row)
//{
//    thermostatEvent ev;
//    return ev;
//}

void thermoEventMonitor::captureThermostatEventInfo(QString dayOfWeek, QString targetTime, int mytargetTemp, bool isHeat)
{
    qDebug() << "Correctly captured:" << dayOfWeek << targetTime << mytargetTemp << isHeat;
    AddThermoEvent(dayOfWeek,targetTime, mytargetTemp, isHeat);
    qDebug() << "We have" << m_eventModel->rowCount(QModelIndex()) << "thermo events";
    for(int i = 0; i < m_eventModel->rowCount(QModelIndex()); i++) {
        thermostatEvent ev = m_eventModel->getData(i);
        qDebug() << i << ":" << ev.eventDayOfWeek() << ev.eventTime() << ev.eventTemp() << ev.eventIsHeat();
    }
}

void thermoEventMonitor::AddThermoEvent(QString dayOfWeek, QString targetTime, int mytargetTemp, bool isHeat)
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
        ev.setEventTemp(convertToKelvin(mytargetTemp, "F"));
        ev.setEventIsHeat(isHeat);
        qDebug() << "adding:" << ev.eventDayOfWeek() << ev.eventTime() << ev.eventTemp() << ev.eventIsHeat();
        AddThermoEvent(ev);
        qDebug() << "Event count is now:" << m_eventModel->rowCount(QModelIndex());
    }
}

void thermoEventMonitor::AddThermoEvent( thermostatEvent &ev )
{
    m_eventModel->insertRows(0, 1, QModelIndex());

    QModelIndex index = m_eventModel->index(0,0,QModelIndex());
    m_eventModel->setData(index, ev );
}

void thermoEventMonitor::ReadThermoEvents(void)
{
    QSettings settings;
    settings.beginGroup(THERMO_GROUPNAME);

    settings.endGroup();
}

void thermoEventMonitor::SaveThermoEvents(void)
{
    QSettings settings;
    settings.beginGroup(THERMO_GROUPNAME);
    settings.endGroup();
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
