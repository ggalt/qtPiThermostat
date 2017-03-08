#ifndef SERVERCONNECTION_H
#define SERVERCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QMutex>
#include <QMutexLocker>

#include "thermostateventmodel.h"

class ServerConnection : public QTcpSocket
{
    Q_OBJECT
public:
    explicit ServerConnection(QObject *parent = Q_NULLPTR);
    void sendThermoData(thermostatData &m_thermostatData);

signals:
    void updateThermostatEvents(void);

public slots:
    void Init(void);

private:
    QMutex mutex;
};

#endif // SERVERCONNECTION_H
