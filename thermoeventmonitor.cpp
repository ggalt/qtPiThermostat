#include "thermoeventmonitor.h"

#define THERMO_GROUPNAME "ThermostatEvents"

thermoEventMonitor::thermoEventMonitor(QObject *parent) :
    QObject(parent)
{
    m_eventModel = NULL;
}

void thermoEventMonitor::setEventModel(thermostatEventModel *t)
{
    if(m_eventModel != NULL)
        m_eventModel->deleteLater();

    m_eventModel = t;
}

void thermoEventMonitor::setThermoEvent( thermostatEvent t)
{

}

//thermostatEvent thermoEventMonitor::thermoEvent(int row)
//{
//    thermostatEvent ev;
//    return ev;
//}

void thermoEventMonitor::AddThermoEvent( thermostatEvent ev )
{

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

