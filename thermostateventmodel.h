#ifndef THERMOSTATEVENTMODEL_H
#define THERMOSTATEVENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QTime>
#include <QList>
#include <QString>
#include <QVariant>
#include <QDataStream>

///
/// \brief The thermostatEvent class
///
class thermostatEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QTime eventTime READ eventTime WRITE setEventTime NOTIFY eventTimeChanged)
    Q_PROPERTY(qreal eventTemp READ eventTemp WRITE setEventTemp NOTIFY eventTempChanged)
    Q_PROPERTY(QString eventDayOfWeek READ eventDayOfWeek WRITE setEventDayOfWeek NOTIFY eventDayOfWeekChanged)
    Q_PROPERTY(bool eventIsHeat READ eventIsHeat WRITE setEventIsHeat NOTIFY eventIsHeatChanged)

public:
    thermostatEvent(QObject *parent=0);
    thermostatEvent(const thermostatEvent &ev);

    void setEventTime(QString t);
    void setEventTime(QTime t);
    void setEventTemp(qreal t);
    void setEventDayOfWeek(QString t);
    void setEventIsHeat(bool t);

    QTime eventTime(void) const {return m_eventTime;}
    qreal eventTemp(void) const {return m_eventTemp;}
    QString eventDayOfWeek(void) const {return m_eventDayOfWeek;}
    bool eventIsHeat(void) const {return m_eventIsHeat;}

signals:
    void eventTimeChanged(void);
    void eventTempChanged(void);
    void eventDayOfWeekChanged(void);
    void eventIsHeatChanged(void);

private:
    friend QDataStream& operator << (QDataStream& out, const thermostatEvent& ev);
    friend QDataStream& operator >> (QDataStream& in, thermostatEvent& ev);

private:
    QTime m_eventTime;
    qreal m_eventTemp;
    QString m_eventDayOfWeek;
    bool m_eventIsHeat;
};


///
/// \brief The thermostatEventModel class
///
class thermostatEventModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit thermostatEventModel(QObject *parent = 0);

public:
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    bool setData(const QModelIndex &index, thermostatEvent *value, int role = Qt::EditRole);
    bool insertRows(int position, int rows, const QModelIndex &index = QModelIndex());
    bool removeRows(int position, int rows, const QModelIndex &index = QModelIndex());

signals:

public slots:

private:
    QList<thermostatEvent*> m_events;

};

#endif // THERMOSTATEVENTMODEL_H
