#ifndef THERMOEVENTMONITOR_H
#define THERMOEVENTMONITOR_H

#include <QObject>
#include <QTimer>
#include <QString>
#include <QDateTime>
#include <QSettings>
#include <QModelIndex>
#include <QDeclarativeContext>

#include "thermostateventmodel.h"

class thermoEventMonitor : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(thermostatEventModel* eventModel READ eventModel WRITE setEventModel NOTIFY eventModelChanged)

public:
    explicit thermoEventMonitor(QObject *parent = 0);
    ~thermoEventMonitor();

    void setEventModel(thermostatEventModel *t);
    void connectEventModel(QDeclarativeContext *mainContext);

    const thermostatEventModel* eventModel(void) { return &m_eventModel; }

    void ReadThermoEvents(void);
    void SaveThermoEvents(void);
    void AddThermoEvent(thermostatEvent &ev );
    void AddThermoEvent(QString dayOfWeek, QString targetTime, qreal lowTemp, qreal hiTemp);

signals:
    void eventModelChanged(void);

public slots:
    void captureThermostatEventInfo(QString dayOfWeek, QString targetTime, qreal lowTemp, qreal hiTemp);
    void deleteListItem(int i);
    void clearList(void);
private:
    qreal convertToKelvin(int temp, QString scale);

    QTimer tick;
    QString thisDayOfWeek;
    thermostatEventModel m_eventModel;
};

#endif // THERMOEVENTMONITOR_H
