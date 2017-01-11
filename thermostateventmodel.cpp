#include "thermostateventmodel.h"

thermostatEvent::thermostatEvent(QObject *parent) : QObject(parent)
{

}

thermostatEvent::thermostatEvent(const thermostatEvent& ev) : QObject(ev.parent())
{
    m_eventTime = ev.eventTime();
    m_eventTemp = ev.eventTemp();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventIsHeat = ev.eventIsHeat();
}

thermostatEvent &thermostatEvent::operator=(const thermostatEvent &ev)
{
    m_eventTime = ev.eventTime();
    m_eventTemp = ev.eventTemp();
    m_eventDayOfWeek = ev.eventDayOfWeek();
    m_eventIsHeat = ev.eventIsHeat();
}

void thermostatEvent::setEventTime(QString t)
{
    QTime ev = QTime::fromString(t, "mm:ss AP");
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

void thermostatEvent::setEventIsHeat(bool t)
{
    m_eventIsHeat = t;
    emit eventIsHeatChanged();
}

QDataStream& operator << (QDataStream& out, const thermostatEvent& ev)
{
    out << ev.eventDayOfWeek() << ev.eventTime() << ev.eventTemp() << ev.eventIsHeat();
    return out;
}

QDataStream& operator >> (QDataStream& in, thermostatEvent& ev)
{
    QTime mv_eventTime;
    qreal mv_eventTemp;
    QString mv_eventDayOfWeek;
    bool mv_eventIsHeat;

    in >> mv_eventDayOfWeek >> mv_eventTime >> mv_eventTemp >> mv_eventIsHeat;

    ev.setEventDayOfWeek(mv_eventDayOfWeek);
    ev.setEventTime(mv_eventTime);
    ev.setEventTemp(mv_eventTemp);
    ev.setEventIsHeat(mv_eventIsHeat);

    return in;

}


thermostatEventModel::thermostatEventModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

int thermostatEventModel::rowCount(const QModelIndex &parent) const
{
    return m_events.count();
}

QVariant thermostatEventModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    if( index.row() >= m_events.count() || index.row() < 0 )
        return QVariant();

//    if( role == Qt::DisplayRole ) {
//        return QVariant::fromValue(m_events.at(index.row()));
//    } else
        return QVariant();
}

thermostatEvent thermostatEventModel::getData(int row)
{
    return m_events.at(row);
}

bool thermostatEventModel::setData(const QModelIndex &index, thermostatEvent &value, int role)
{
    if (index.isValid() && role == Qt::EditRole) {
        int row = index.row();

        m_events.replace(row, value);
//        emit(dataChanged(index, index));

        return true;
    }

    return false;
}

bool thermostatEventModel::insertRows(int position, int rows, const QModelIndex &index)
{
    Q_UNUSED(index);
    beginInsertRows(QModelIndex(), position, position + rows - 1);

    for (int row = 0; row < rows; ++row) {
        thermostatEvent ev;
        m_events.insert(position, &ev);
    }

    endInsertRows();
    return true;
}

bool thermostatEventModel::removeRows(int position, int rows, const QModelIndex &index)
{
    Q_UNUSED(index);
    beginRemoveRows(QModelIndex(), position, position + rows - 1);

    for (int row = 0; row < rows; ++row) {
        m_events.removeAt(position);
    }

    endRemoveRows();
    return true;
}

