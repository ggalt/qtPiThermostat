#ifndef SERVERCONNECTION_H
#define SERVERCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QMutex>
#include <QMutexLocker>

#include "thermostateventmodel.h"

#define SERVER_ADDRESS "127.0.0.1"
#define SERVER_PORT 4567

class ServerConnection : public QTcpSocket
{
    Q_OBJECT
public:
    explicit ServerConnection(QObject *parent = Q_NULLPTR);

//public slots:
    void sendThermoData(thermostatData &m_thermostatData);

signals:
    void finished(void);

private:
    QMutex mutex;
};

#endif // SERVERCONNECTION_H
