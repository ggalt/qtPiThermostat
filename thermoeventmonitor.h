#ifndef THERMOEVENTMONITOR_H
#define THERMOEVENTMONITOR_H

#include <QObject>
#include <QTimer>
#include <QString>
#include <QDateTime>
#include <QSettings>
#include <QModelIndex>

#include "thermostateventmodel.h"

class thermoEventMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(thermostatEventModel* eventModel READ eventModel WRITE setEventModel NOTIFY eventModelChanged)

public:
    explicit thermoEventMonitor(QObject *parent = 0);

    void setEventModel(thermostatEventModel *t);

    thermostatEventModel *eventModel(void) { return m_eventModel; }

    void ReadThermoEvents(void);
    void SaveThermoEvents(void);
    void AddThermoEvent( thermostatEvent ev );
    void AddThermoEvent(QString dayOfWeek, QString targetTime, int mytargetTemp, bool isHeat);

signals:
    void eventModelChanged(void);

public slots:
    void captureThermostatEventInfo(QString dayOfWeek, QString targetTime, int mytargetTemp, bool isHeat);


private:
    thermostatEventModel *m_eventModel;
    QTimer tick;
    QString thisDayOfWeek;
};

#endif // THERMOEVENTMONITOR_H
