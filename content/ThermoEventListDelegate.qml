import QtQuick 1.1

Item {
    id: thermoEventListDelegate
    width: 320
    height: 40

    Text {
        id: txtDay
        text: eventDayOfWeek
        width: 60
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    Text {
        id: txtTime
        text: eventTime
        width: 60
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: txtDay.right
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    Text {
        id: txtTemp
        text: eventTemp
        width: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12
        anchors.left: txtTime.right
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    Image {
        id: imageHeat
        x: 237
        width: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: "../icons/heating.png"
    }
}
