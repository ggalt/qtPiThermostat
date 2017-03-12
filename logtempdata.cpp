#include "logtempdata.h"

logTempData::logTempData(QString host, quint16 port, QObject *parent) :
    m_host(host), m_port(port), QTcpSocket(parent)
{
    dataLoaded = false;
}

void logTempData::setThermoData(thermostatData &m_thermoData)
{
    QMutexLocker(&mutex);
    m_thermostatData.setIndoorHumidity(m_thermoData.indoorHumidity());
    m_thermostatData.setIndoorTemp(m_thermoData.indoorTemp());
    m_thermostatData.setOutdoorTemp(m_thermoData.outdoorTemp());
    m_thermostatData.setTimestamp(m_thermoData.timestamp());
    m_thermostatData.setThermostatRange(m_thermoData.thermostatRange());
    dataLoaded = true;
}

void logTempData::process()
{
    QMutexLocker m(&mutex);
    if(!dataLoaded) {
        emit error("Data Not Loaded");
        return;
    }
    connectToHost(m_host, m_port);
    waitForConnected();

    QDataStream out(this);

    out << m_thermostatData;
    disconnectFromHost();
    waitForDisconnected();
    dataLoaded = false;
    emit finished();
}
