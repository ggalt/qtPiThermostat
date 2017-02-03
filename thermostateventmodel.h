#ifndef THERMOSTATEVENTMODEL_H
#define THERMOSTATEVENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QTime>
#include <QList>
#include <QString>
#include <QVariant>
#include <QDataStream>
#include <QHash>

///
/// \brief The thermostatEvent class
///
class thermostatEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QTime eventTime READ eventTime WRITE setEventTime NOTIFY eventTimeChanged)
//    Q_PROPERTY(DayOfTheWeek eventDayOfWeek READ eventDayOfWeek WRITE setEventDayOfWeek NOTIFY eventDayOfWeekChanged)
    Q_PROPERTY(QString eventDayOfWeek READ eventDayOfWeek WRITE setEventDayOfWeek NOTIFY eventDayOfWeekChanged)
    Q_PROPERTY(qreal eventLoTemp READ eventLoTemp WRITE setEventLoTemp NOTIFY eventLoTempChanged)
    Q_PROPERTY(qreal eventHiTemp READ eventHiTemp WRITE setEventHiTemp NOTIFY eventHiTempChanged)

public:
    thermostatEvent(QObject *parent=0);
    thermostatEvent(const thermostatEvent &ev);
    thermostatEvent &operator=(const thermostatEvent &other);


    void setEventTime(QString t);
    void setEventTime(QTime t);
    void setEventDayOfWeek(QString t);
    void setEventLoTemp(qreal t);
    void setEventHiTemp(qreal t);

    QTime eventTime(void) const {return m_eventTime;}
    QString eventDayOfWeek(void) const;
    qreal eventLoTemp(void) const {return m_eventLoTemp;}
    qreal eventHiTemp(void) const {return m_eventHiTemp;}

public:
    enum DayOfTheWeek { Sunday=0, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, AllWeek, Weekend, WeekDays };
    Q_ENUMS(DayOfTheWeek)

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
        TimeRole,
        LoTempRole,
        HiTempRole
    };

public:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    thermostatEvent getData(int row) const;
    void sort(int columnNumber, Qt::SortOrder=Qt::AscendingOrder);

    void addThermostatEvent(const thermostatEvent &ev);

//    bool setData(const QModelIndex &index, thermostatEvent &value, int role = Qt::EditRole);
//    bool insertRows(int position, int rows, const QModelIndex &index = QModelIndex());
//    bool removeRows(int position, int rows, const QModelIndex &index = QModelIndex());

signals:

public slots:

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<thermostatEvent> m_events;

};
Q_DECLARE_METATYPE(thermostatEventModel)
Q_DECLARE_METATYPE(thermostatEvent)
#endif // THERMOSTATEVENTMODEL_H
