#include "serverconnection.h"

ServerConnection::ServerConnection(QObject *parent) :
    QTcpSocket(parent)
{
}
