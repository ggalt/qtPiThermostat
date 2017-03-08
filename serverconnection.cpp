#include "serverconnection.h"

ServerConnection::ServerConnection(QObject *parent) :
    QTcpSocket(parent)
{
}

void ServerConnection::sendThermoData(thermostatData &m_thermostatData)
{
    m_thermostatData.setIndoorTemp(currentIndoorTemp);
    m_thermostatData.setIndoorHumidity(currentIndoorHumidity);
    m_thermostatData.setThermostatRange(currentTempRange);
    m_thermostatData.setOutdoorTemp(m_weather->currentWeather().temperature());
    m_thermostatData.setTimestamp(QDateTime::currentDateTime());

    qint64 bytesToBeWritten = 0;
    bytesToBeWritten = m_thermostatData.dataPayloadSize();

    out << m_thermostatData;
}

void ServerConnection::Init()
{

}
