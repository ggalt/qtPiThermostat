#include "thermostateventmodel.h"
#include <QDebug>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief thermostatEvent::thermostatEvent
/// \param parent
///
thermostatEvent::thermostatEvent(QObject *parent) : QObject(parent)
{

}

thermostatEvent::thermostatEvent(const thermostatEvent& ev) : QObject(ev.parent())
{
    m_eventTime = ev.eventTime();
    setEventDayOfWeek(ev.eventDayOfWeek());
    m_eventLoTemp = ev.eventLoTemp();
    m_eventHiTemp = ev.eventHiTemp();
}

thermostatEvent &thermostatEvent::operator=(const thermostatEvent &ev)
{
    setParent(ev.parent());
    m_eventTime = ev.eventTime();
    setEventDayOfWeek(ev.eventDayOfWeek());
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
    if(t == "SUN")
        m_eventDayOfWeek = Sunday;
    else if(t == "MON")
        m_eventDayOfWeek = Monday;
    else if(t == "TUE")
        m_eventDayOfWeek = Tuesday;
    else if(t == "WED")
        m_eventDayOfWeek = Wednesday;
    else if(t == "THU")
        m_eventDayOfWeek = Thursday;
    else if(t == "FRI")
        m_eventDayOfWeek = Friday;
    else if(t == "SAT")
        m_eventDayOfWeek = Saturday;

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

QString thermostatEvent::eventDayOfWeek() const
{
    if(m_eventDayOfWeek==Sunday)
        return QString("SUN");
    else    if(m_eventDayOfWeek==Monday)
        return QString("MON");
    else    if(m_eventDayOfWeek==Tuesday)
        return QString("TUE");
    else    if(m_eventDayOfWeek==Wednesday)
        return QString("WED");
    else    if(m_eventDayOfWeek==Thursday)
        return QString("THU");
    else    if(m_eventDayOfWeek==Friday)
        return QString("FRI");
    else    if(m_eventDayOfWeek==Saturday)
        return QString("SAT");
    else
        return NULL;
}

thermostatEvent::DayOfTheWeek thermostatEvent::rawEventDayOfWeek() const
{
    return m_eventDayOfWeek;
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief thermostatEventModel::thermostatEventModel
/// \param parent
///
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
    } else if( role == RawDayRole ) {
        return QVariant::fromValue(ev.rawEventDayOfWeek());
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

//void thermostatEventModel::sort(int columnNumber, Qt::SortOrder)
//{
//}

bool thermostatEventModel::addThermostatEvent(const thermostatEvent &ev)
{
    // insert rows in day and time sort order
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    for( int i = 0; i < m_events.size(); i++) {

        if( (int)ev.rawEventDayOfWeek() < (int)m_events.at(i).rawEventDayOfWeek() ) {
            m_events.insert(i,ev);
            endInsertRows();
            qDebug() << ev.eventDayOfWeek() << "is before" << m_events.at(i).eventDayOfWeek();
            return true;
        }

        else if( (int)ev.rawEventDayOfWeek() == (int)m_events.at(i).rawEventDayOfWeek() ) {
            qDebug() << ev.eventDayOfWeek() << "is the same as" << m_events.at(i).eventDayOfWeek();

            if( ev.eventTime() < m_events.at(i).eventTime() ) {
                m_events.insert(i,ev);
                endInsertRows();
                qDebug() <<  ev.eventTime() << "is earlier than" << m_events.at(i).eventTime();
                return true;
            }

            else if( ev.eventTime() == m_events.at(i).eventTime() ) {        // oops!!  we seem to have a duplicate day and time,  Replace current.
                qDebug() << ev.eventDayOfWeek() << "and" << ev.eventTime() << "==" << m_events.at(i).eventDayOfWeek() << "and" << m_events.at(i).eventTime();
                m_events.replace(i,ev);
                endInsertRows();
                return true;
            }
        }
    }

    m_events.append(ev);
    endInsertRows();
    qDebug() << ev.eventDayOfWeek() << ev.eventTime() << "has been appended";

    return true;
}

QHash<int, QByteArray> thermostatEventModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[DayRole] = "eventDayOfWeek";
    roles[RawDayRole] = "rawEventDayOfWeek";
    roles[TimeRole] = "eventTime";
    roles[LoTempRole] = "eventLoTemp";
    roles[HiTempRole] = "eventHiTemp";
    return roles;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief thermoSortFilterProxyModel::thermoSortFilterProxyModel
/// \param parent
///
thermoSortFilterProxyModel::thermoSortFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{

}

void thermoSortFilterProxyModel::setFilterDay(QString day)
{
    if(day == "SUN")
        setFilterDay(thermostatEvent::Sunday);
    else if(day == "MON")
        setFilterDay(thermostatEvent::Monday);
    else if(day == "TUE")
        setFilterDay(thermostatEvent::Tuesday);
    else if(day == "WED")
        setFilterDay(thermostatEvent::Wednesday);
    else if(day == "THU")
        setFilterDay(thermostatEvent::Thursday);
    else if(day == "FRI")
        setFilterDay(thermostatEvent::Friday);
    else if(day == "SAT")
        setFilterDay(thermostatEvent::Saturday);
    else
        setFilterDay(thermostatEvent::AllWeek);
}

void thermoSortFilterProxyModel::setFilterDay(thermostatEvent::DayOfTheWeek day)
{
    filterDay = day;
    invalidateFilter();
}

bool thermoSortFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    if(filterDay == thermostatEvent::AllWeek) {
        qDebug() << "give all days";
        return true;
    }
    QModelIndex index0 = sourceModel()->index(sourceRow, 0, sourceParent);
    qDebug() << "data returns:" << sourceModel()->data(index0,thermostatEventModel::RawDayRole).toInt() << "filter is:" << filterDay;
    bool retVal = sourceModel()->data(index0,thermostatEventModel::RawDayRole).toInt() == (int)filterDay;

    qDebug() << "resolves to:" << retVal;
    return retVal;

//    return sourceModel()->data(index0,thermostatEventModel::RawDayRole) == filterDay;
}

bool thermoSortFilterProxyModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
    int leftDay = sourceModel()->data(left,thermostatEventModel::RawDayRole).toInt();
    int rightDay = sourceModel()->data(right,thermostatEventModel::RawDayRole).toInt();



    if( leftDay < rightDay ) {
        qDebug() << leftDay << "is less than" << rightDay;
        return true;
    }
    else if( leftDay > rightDay ) {
        qDebug() << leftDay << "is greater than" << rightDay;
        return false;
    }
    else {
        qDebug() << leftDay << "is the same as" << rightDay;
        QTime leftTime = sourceModel()->data(left,thermostatEventModel::TimeRole).toTime();
        QTime rightTime = sourceModel()->data(right,thermostatEventModel::TimeRole).toTime();
        if(leftTime < rightTime) {
            qDebug() << leftTime << "is less than" << rightTime;
            return true;
        }
        else {
            qDebug() << leftTime << "is greater than" << rightTime;
            return false;
        }
    }

    qDebug() << "**** not sure what we are doing here!! ****";
    return false;
}
