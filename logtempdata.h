#ifndef LOGTEMPDATA_H
#define LOGTEMPDATA_H

#include <QObject>
#include <QTcpSocket>
#include <QMutex>
#include <QMutexLocker>
#include <QDataStream>

#include "thermostateventmodel.h"


class logTempData : public QTcpSocket
{
    Q_OBJECT
public:
    explicit logTempData(QString host = "127.0.0.1", quint16 port = 4567, QObject *parent = Q_NULLPTR);

    void setThermoData(thermostatData &m_thermoData);

public slots:
    void process(void);

signals:
    void finished(void);
    void error(QString);

private:
    QMutex mutex;
    QString m_host;
    quint16 m_port;
    thermostatData m_thermostatData;
    bool dataLoaded;
};

#endif // LOGTEMPDATA_H
