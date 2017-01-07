#ifndef THERMOEVENTMONITOR_H
#define THERMOEVENTMONITOR_H

#include <QObject>
#include <QTimer>
#include <QString>
#include <QDateTime>
#include <QSettings>

#include "thermostateventmodel.h"

class thermoEventMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(thermostatEventModel* eventModel READ eventModel WRITE setEventModel NOTIFY eventModelChanged)
//    Q_PROPERTY(thermostatEvent thermoEvent READ thermoEvent WRITE setThermoEvent NOTIFY thermoEventChanged)

public:
    explicit thermoEventMonitor(QObject *parent = 0);

    void setEventModel(thermostatEventModel *t);
    void setThermoEvent( thermostatEvent t);

    thermostatEventModel *eventModel(void) { return m_eventModel; }
//    thermostatEvent thermoEvent(int row);

    void ReadThermoEvents(void);
    void SaveThermoEvents(void);
    void AddThermoEvent( thermostatEvent ev );

signals:
    void eventModelChanged(void);

public slots:

private:
    thermostatEventModel *m_eventModel;
    QTimer tick;
    QString thisDayOfWeek;
};

#endif // THERMOEVENTMONITOR_H
