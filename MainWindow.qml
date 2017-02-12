import QtQuick 1.1

Rectangle {
    id: mainWindowRectangle
    objectName: "mainWindowRectangle"
    width: 320
    height: 240

//    property alias loTargetTemp: targetLoTemp.text
//    property alias hiTargetTemp: targetHiTemp.text

    opacity: 0

//    Component.onCompleted: mainRectangle.weatherIconTimer.triggered.connect(setCurrentWeatherIcon)

    FontLoader {
        id: openSans
        source: "qrc:/fonts/OpenSans-Regular.ttf"
     }

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 1
            color: "#62c288"
        }
    }

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    function fadeIn() {
        fadeInAnimation.start()
    }

    function setCurrentWeatherIcon() {
//        imgCurrentWeather.source = setWeatherIcon(mainRectangle.currentWeatherIcon)
        imgCurrentWeather.source = setWeatherIcon(mainRectangle.currentWeatherIcon)
    }

    signal loadWindow(string newWinName)
    signal showEventWindow

    Text {
        id: txtCurrentTemp
        x: 101
        y: 73
        text: mainRectangle.curTemp
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 65

        MouseArea {
            id: maCurrentTemp
            anchors.fill: parent
            onClicked: mainRectangle.changeAppState("EventWindowState")
        }
    }

    Text {
        id: txtDate
        y: 204
        text: mainRectangle.curDate
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        font.pointSize: 18
    }

    Text {
        id: txtTime
        x: 286
        y: 218
        text: mainRectangle.curTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        font.pointSize: 18
    }

    Image {
        id: imgCurrentWeather
        width: 80
        height: 80
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2
        source: mainRectangle.setWeatherIcon(mainRectangle.currentWeatherIcon)

        MouseArea {
            id: maWeather
            z: 1
            anchors.fill: parent
            onClicked: mainRectangle.changeAppState("WeatherWindowState")
        }

        Text {
            id: outsideTemp
            x: 86
            y: 26
            text: outsideCurrentTemp
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pointSize: 18
        }
    }

    Text {
        id: txtRelHum
        x: 292
        text: curHumidity+"%"
        anchors.top: parent.top
        anchors.topMargin: 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.rightMargin: 2
        font.pointSize: 18
    }

    Image {
        id: imgCoolingState
        y: 138
        width: 60
        height: 60
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 2
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
        opacity: 1
        source: "icons/heating.png"
    }

    Text {
        id: lblRelHum
        x: 105
        y: 12
        text: qsTr("Humidity:")
        anchors.right: txtRelHum.left
        anchors.verticalCenter: txtRelHum.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 16
    }

    Text {
        id: targetHiTemp
        x: 298
        y: 49
        color: "#ff0101"
        text: mainRectangle.targetHiTemp
        font.pointSize: 18
        anchors.bottom: imgCoolingState.top
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 2
    }

    Text {
        id: targetLoTemp
        x: 285
        color: "#2e02ff"
        text: mainRectangle.targetLoTemp
        anchors.topMargin: 5
        font.pointSize: 18
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: imgCoolingState.bottom
    }
}
