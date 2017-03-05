#ifndef SERVERCONNECTION_H
#define SERVERCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include "thermostateventmodel.h"

class ServerConnection : public QTcpSocket
{
    Q_OBJECT
public:
    explicit ServerConnection(QObject *parent = Q_NULLPTR);

signals:
    void updateThermostatEvents(void);

public slots:

private:
};

#endif // SERVERCONNECTION_H
