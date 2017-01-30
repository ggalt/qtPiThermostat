import QtQuick 1.1

Rectangle {
    id: thermoEventListDelegate
    width: 320
    height: 40
    border.color: "#ccffffff"
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 1
            color: "#66000000"
        }
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        onPressAndHold: {
            console.log("pressed", index)
            mainRectangle.changeAppState("MainWindowState")
        }
    }

    Rectangle {
        id: rectangle1
        width: 80
        color: "#00000000"
        border.color: "#b3ffffff"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: txtDayOfWeek
            text: eventDayOfWeek
            anchors.fill: parent
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Rectangle {
        id: rectangle2
        y: 4
        width: 100
        color: "#00000000"
        anchors.leftMargin: 2
        anchors.left: rectangle1.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0
        clip: true
        Text {
            id: txtEventTime
            text: Qt.formatTime(eventTime, "hh:mm AP")
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#b3ffffff"
    }

    Rectangle {
        id: rectangle3
        width: 60
        color: "#330211ff"
        anchors.leftMargin: 2
        anchors.left: rectangle2.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0
        clip: true
        Text {
            id: txtEventTempLo
            text: mainRectangle.convertFromKelvin(eventLoTemp).toFixed(0)
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#b3ffffff"
    }

    Rectangle {
        id: rectangle4
        x: 0
        y: 0
        width: 60
        color: "#33ff0202"
        anchors.leftMargin: 2
        anchors.left: rectangle3.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0
        clip: true
        Text {
            id: txtEventTempHi
            text: mainRectangle.convertFromKelvin(eventHiTemp).toFixed(0)
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#b3ffffff"
    }
}
