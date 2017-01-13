#include "thermostateventmodel.h"

thermostatEvent::thermostatEvent(QObject *parent) : QObject(parent)
{

}

thermostatEvent::thermostatEvent(const thermostatEvent& ev) : QObject(ev.parent())
{
    m_eventTime = ev.eventTime();
    m_eventTemp = ev.eventTemp();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventIsHeat = ev.eventMode();
}

thermostatEvent &thermostatEvent::operator=(const thermostatEvent &ev)
{
    setParent(ev.parent());
    m_eventTime = ev.eventTime();
    m_eventTemp = ev.eventTemp();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventIsHeat = ev.eventMode();
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

void thermostatEvent::setEventTemp(qreal t)
{
    m_eventTemp = t;
    emit eventTempChanged();
}

void thermostatEvent::setEventDayOfWeek(QString t)
{
    m_eventDayOfWeek = t;
    emit eventDayOfWeekChanged();
}

void thermostatEvent::setEventMode(bool t)
{
    m_eventIsHeat = t;
    emit eventModeChanged();
}

QDataStream& operator << (QDataStream& out, const thermostatEvent& ev)
{
    out << ev.eventDayOfWeek() << ev.eventTime() << ev.eventTemp() << ev.eventMode();
    return out;
}

QDataStream& operator >> (QDataStream& in, thermostatEvent& ev)
{
    QTime mv_eventTime;
    qreal mv_eventTemp;
    QString mv_eventDayOfWeek;
    bool mv_eventMode;

    in >> mv_eventDayOfWeek >> mv_eventTime >> mv_eventTemp >> mv_eventMode;

    ev.setEventDayOfWeek(mv_eventDayOfWeek);
    ev.setEventTime(mv_eventTime);
    ev.setEventTemp(mv_eventTemp);
    ev.setEventMode(mv_eventMode);

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
    } else if( role == TempRole ) {
        return QVariant::fromValue(ev.eventTemp());
    } else if( role == ModeRole ) {
        return QVariant::fromValue(ev.eventMode());
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
    roles[TempRole] = "eventTemp";
    roles[ModeRole] = "eventMode";
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

