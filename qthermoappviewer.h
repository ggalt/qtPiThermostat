#ifndef QTHERMOAPPVIEWER_H
#define QTHERMOAPPVIEWER_H

#include "qtquick1applicationviewer.h"
#include "weathernetworkconnection.h"
#include "thermostateventmodel.h"
#include "thermoeventmonitor.h"
#include "source/Raspberry_Pi/pi_dht_read.h"
#include "serverconnection.h"

#include <QDeclarativeItem>
#include <QList>
#include <QTimer>
#include <QDateTime>

///
/// \brief The qThermoAppViewer class
///
/// Subclass the Application viewer so we can grab signals from
/// QML and respond to them
///

class qThermoAppViewer : public QtQuick1ApplicationViewer
{
    Q_OBJECT
public:
    explicit qThermoAppViewer(QtQuick1ApplicationViewer *parent = 0);
    void Init(void);

signals:

public slots:
    void CheckOutsideTemp(void);
    void CheckIndoorCondition(void);
    void CheckIndoorTempRange(void);
    void appStateSignal(const QString& state);
    void logCurrentStatus(void);
    void checkWriteStatus(qint64 bytes);

private:
    QObject *mainRec;
    bool initializingApp;

    WeatherNetworkConnection *m_weather;
    thermoEventMonitor *m_eventMonitor;
    thermostatEventModel m_eventModel;

    static QDeclarativeItem* FindItemByName(QList<QObject*> nodes, const QString& name);

    float currentIndoorTemp;
    float currentIndoorHumidity;
    QPair<qreal,qreal> currentTempRange;
    QTimer oneSecondTick;
    QTimer fiveSecondTick;
    QTimer oneMinuteTick;

    ServerConnection *m_connection;
    qint64 bytesToBeWritten;
};

#endif // QTHERMOAPPVIEWER_H
