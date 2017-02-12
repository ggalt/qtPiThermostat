#ifndef THERMOSTATEVENTMODEL_H
#define THERMOSTATEVENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QTime>
#include <QList>
#include <QListIterator>
#include <QString>
#include <QVariant>
#include <QDataStream>
#include <QHash>
#include <QPair>

#define DEFAULT_LO 288.706  // equivalent to 60F or 16C
#define DEFAULT_HI 299.817  // equivalent to 80F or 27C

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
/// \brief The thermostatEvent class
///
class thermostatEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QTime eventTime READ eventTime WRITE setEventTime NOTIFY eventTimeChanged)
    Q_PROPERTY(DayOfTheWeek rawEventDayOfWeek READ rawEventDayOfWeek)
    Q_PROPERTY(QString eventDayOfWeek READ eventDayOfWeek WRITE setEventDayOfWeek NOTIFY eventDayOfWeekChanged)
    Q_PROPERTY(qreal eventLoTemp READ eventLoTemp WRITE setEventLoTemp NOTIFY eventLoTempChanged)
    Q_PROPERTY(qreal eventHiTemp READ eventHiTemp WRITE setEventHiTemp NOTIFY eventHiTempChanged)

public:
    thermostatEvent(QObject *parent=0);
    thermostatEvent(const thermostatEvent &ev);
    thermostatEvent &operator=(const thermostatEvent &other);

    enum DayOfTheWeek { Sunday=0, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, AllWeek, Weekend, WeekDays };
    Q_ENUMS(DayOfTheWeek)


    void setEventTime(QString t);
    void setEventTime(QTime t);
    void setEventDayOfWeek(QString t);
    void setEventLoTemp(qreal t);
    void setEventHiTemp(qreal t);

    QTime eventTime(void) const {return m_eventTime;}
    QString eventDayOfWeek(void) const;
    thermostatEvent::DayOfTheWeek rawEventDayOfWeek(void) const;
    qreal eventLoTemp(void) const {return m_eventLoTemp;}
    qreal eventHiTemp(void) const {return m_eventHiTemp;}

    static DayOfTheWeek getDOWEnum( QString day );
    static QString getDOWString( DayOfTheWeek day);

signals:
    void eventTimeChanged(void);
    void eventDayOfWeekChanged(void);
    void eventLoTempChanged(void);
    void eventHiTempChanged(void);

private:
    friend QDataStream& operator << (QDataStream& out, const thermostatEvent& ev);
    friend QDataStream& operator >> (QDataStream& in, thermostatEvent& ev);

private:
    QTime m_eventTime;
    DayOfTheWeek m_eventDayOfWeek;
    qreal m_eventLoTemp;
    qreal m_eventHiTemp;
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
/// \brief The thermostatEventModel class
///
class thermostatEventModel : public QAbstractListModel
{
    Q_OBJECT
public:
//    explicit thermostatEventModel(QObject *parent = 0);
    thermostatEventModel(QObject *parent = 0);
    thermostatEventModel(const thermostatEventModel &ev);
    thermostatEventModel &operator =(const thermostatEventModel &ev);

    enum thermostatEventRoles {
        DayRole = Qt::UserRole + 1,
        RawDayRole,
        TimeRole,
        LoTempRole,
        HiTempRole
    };

public:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    thermostatEvent getData(int row) const;

    bool addThermostatEvent(const thermostatEvent &ev);
    void deleteThermostatEvent( int row );
    void clearEventList(void);

    QPair<qreal, qreal> getCurrentSettings(QString day, QTime time);

signals:

public slots:

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<thermostatEvent> m_events;
    QPair<qreal,qreal> m_tempRange;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
/// \brief The thermoSortFilterProxyModel class
///
class thermoSortFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    thermoSortFilterProxyModel(QObject *parent = 0);

    void setFilterDay(QString day);
    void setFilterDay(thermostatEvent::DayOfTheWeek day);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

private:
    thermostatEvent::DayOfTheWeek filterDay;
};

Q_DECLARE_METATYPE(thermostatEvent::DayOfTheWeek)
Q_DECLARE_METATYPE(thermostatEventModel::thermostatEventRoles)
Q_DECLARE_METATYPE(thermostatEventModel)
Q_DECLARE_METATYPE(thermostatEvent)
#endif // THERMOSTATEVENTMODEL_H
