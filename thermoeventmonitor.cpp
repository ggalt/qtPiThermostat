#include "thermoeventmonitor.h"

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

void thermoEventMonitor::AddThermoEvent( thermostatEvent ev )
{
    m_eventModel->insertRows(0, 1, QModelIndex());

    QModelIndex index = m_eventModel->index(0,0,QModelIndex());
    m_eventModel->setData(index, &ev );
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
