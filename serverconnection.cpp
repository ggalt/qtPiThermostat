#include "serverconnection.h"

ServerConnection::ServerConnection(QObject *parent) :
    QTcpSocket(parent)
{
}

void ServerConnection::sendThermoData(thermostatData &m_thermostatData)
{
    QMutexLocker m(&mutex);
    connectToHost(SERVER_ADDRESS, SERVER_PORT);
    waitForConnected();

    QDataStream out(this);

    out << m_thermostatData;
    disconnectFromHost();
    waitForDisconnected();
    emit finished();
}

