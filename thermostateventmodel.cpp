#include "thermostateventmodel.h"

thermostatEvent::thermostatEvent(QObject *parent) : QObject(parent)
{

}

thermostatEvent::thermostatEvent(const thermostatEvent& ev) : QObject(ev.parent())
{
    m_eventTime = ev.eventTime();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventLoTemp = ev.eventLoTemp();
    m_eventHiTemp = ev.eventHiTemp();
}

thermostatEvent &thermostatEvent::operator=(const thermostatEvent &ev)
{
    setParent(ev.parent());
    m_eventTime = ev.eventTime();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventLoTemp = ev.eventLoTemp();
    m_eventHiTemp = ev.eventHiTemp();
}

void thermostatEvent::setEventTime(QString t)
{
    QTime ev = QTime::fromString(t, "hh:mm AP");
    setEventTime(ev);
}

void thermostatEvent::setEventTime(QTime t)
{
    m_eventTime = t;
    emit eventTimeChanged();
}

void thermostatEvent::setEventDayOfWeek(QString t)
{
    m_eventDayOfWeek = t;
    emit eventDayOfWeekChanged();
}

void thermostatEvent::setEventLoTemp(qreal t)
{
    m_eventLoTemp = t;
    emit eventLoTempChanged();
}

void thermostatEvent::setEventHiTemp(qreal t)
{
    m_eventHiTemp = t;
    emit eventHiTempChanged();
}


QDataStream& operator << (QDataStream& out, const thermostatEvent& ev)
{
    out << ev.eventDayOfWeek() << ev.eventTime() << ev.eventLoTemp() << ev.eventHiTemp();
    return out;
}

QDataStream& operator >> (QDataStream& in, thermostatEvent& ev)
{
    QTime mv_eventTime;
    QString mv_eventDayOfWeek;
    qreal mv_eventLoTemp;
    qreal mv_eventHiTemp;

    in >> mv_eventDayOfWeek >> mv_eventTime >> mv_eventLoTemp >> mv_eventHiTemp;

    ev.setEventDayOfWeek(mv_eventDayOfWeek);
    ev.setEventTime(mv_eventTime);
    ev.setEventLoTemp(mv_eventLoTemp);
    ev.setEventHiTemp(mv_eventHiTemp);
    return in;
}


thermostatEventModel::thermostatEventModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

thermostatEventModel::thermostatEventModel(const thermostatEventModel &ev)
{
    int oldRowCount = ev.rowCount(QModelIndex());
    insertRows(0, oldRowCount, QModelIndex());

    for(int i = 0; i < oldRowCount; i++) {
        addThermostatEvent(ev.getData(i));
    }
}

thermostatEventModel &thermostatEventModel::operator =(const thermostatEventModel &ev)
{
    int oldRowCount = ev.rowCount(QModelIndex());
    insertRows(0, oldRowCount, QModelIndex());

    for(int i = 0; i < oldRowCount; i++) {
        addThermostatEvent(ev.getData(i));
    }
}


int thermostatEventModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_events.count();
}

QVariant thermostatEventModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    if( index.row() >= m_events.count() || index.row() < 0 )
        return QVariant();

    const thermostatEvent &ev = m_events.at(index.row());

    if( role == Qt::DisplayRole ) {
        return QVariant::fromValue(ev);
    } else if( role == DayRole ) {
        return QVariant::fromValue(ev.eventDayOfWeek());
    } else if( role == TimeRole ) {
        return QVariant::fromValue(ev.eventTime());
    } else if( role == LoTempRole ) {
        return QVariant::fromValue(ev.eventLoTemp());
    } else if( role == HiTempRole ) {
        return QVariant::fromValue(ev.eventHiTemp());
    } else {
        return QVariant();
    }
}

thermostatEvent thermostatEventModel::getData(int row) const
{
    return m_events.at(row);
}

void thermostatEventModel::addThermostatEvent(const thermostatEvent &ev)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_events.append(ev);
    endInsertRows();
}

QHash<int, QByteArray> thermostatEventModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[DayRole] = "eventDayOfWeek";
    roles[TimeRole] = "eventTime";
    roles[LoTempRole] = "eventLoTemp";
    roles[HiTempRole] = "eventHiTemp";
    return roles;
}

//bool thermostatEventModel::setData(const QModelIndex &index, thermostatEvent &value, int role)
//{
//    if (index.isValid() && role == Qt::EditRole) {
//        int row = index.row();

//        m_events.replace(row, value);
////        emit(dataChanged(index, index));

//        return true;
//    }

//    return false;
//}

//bool thermostatEventModel::insertRows(int position, int rows, const QModelIndex &index)
//{
//    Q_UNUSED(index);
//    beginInsertRows(QModelIndex(), position, position + rows - 1);

//    for (int row = 0; row < rows; ++row) {
//        thermostatEvent ev;
//        m_events.insert(position, ev);
//    }

//    endInsertRows();
//    return true;
//}

//bool thermostatEventModel::removeRows(int position, int rows, const QModelIndex &index)
//{
//    Q_UNUSED(index);
//    beginRemoveRows(QModelIndex(), position, position + rows - 1);

//    for (int row = 0; row < rows; ++row) {
//        m_events.removeAt(position);
//    }

//    endRemoveRows();
//    return true;
//}

