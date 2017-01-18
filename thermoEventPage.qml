import QtQuick 1.1
import "content"


Rectangle {
    id: thermoEventRect
    width: 320
    height: 240

    opacity: 0

    property int elementpointSize: 20

    //    property alias dayOfWeek: mainRectangle.eventDayOfWeek
    //    property alias targetTime: mainRectangle.eventTime
    //    property alias targetTemp: mainRectangle.eventTemp
    //    property alias isHeat: mainRectangle.eventIsHeat

    property string dayOfWeek: ""
    property string targetTime: ""
    property double lowTemp: 0.0
    property double hiTemp: 0.0
    property int tempOffset: 0
    property int tempRange: 0
    property string scale: "F"

    property string txthour: ""
    property string txtminute: ""
    property string txtmeridiem: ""

    function setScale() {
        if(scale === "F") {
            tempRange = 60
            tempOffset = 40
            spnHighTemp.currentIndex = 40
            spnLowTemp.currentIndex = 20
        } else {
            tempRange = 34
            tempOffset = 4
        }
    }

    function convertFromKelvin(temp) {
        var returnTemp = 0
        if(scale === "F") {
            returnTemp = (temp * 9 / 5) - 459.67
        } else {
            returnTemp = temp - 273.15
        }
        return returnTemp
    }

    function convert2Kelvin(temp) {
        var returnTemp = 0.0
        if(scale === "F") {
            returnTemp = (temp + 459.67)*5/9
        } else {
            returnTemp = temp + 273.15
        }
        return returnTemp
    }

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
        onCompleted: setScale()
    }

    function fadeIn() {
        fadeInAnimation.start()
    }

    function collectData() {
        dayOfWeek = dowModel.get(lstDayOfTheWeek.currentIndex).dayListElement
        lowTemp = convert2Kelvin(spnLowTemp.currentIndex+tempOffset)
        hiTemp = convert2Kelvin(spnHighTemp.currentIndex+tempOffset)
        txthour = hourModel.get(tmbHour.currentIndex).hourListElement
        txtminute = minuteModel.get(tmbMinute.currentIndex).minuteListElement
        txtmeridiem = apModel.get(tmbAP.currentIndex).lstElement
        targetTime = txthour + ":" + txtminute + " " + txtmeridiem
        console.log("collectData() :", dayOfWeek, targetTime, lowTemp, hiTemp)
    }

    Rectangle {
        id: dayOfWeekRect
        x: 8
        y: 9
        width: 302
        height: 27
        color: "#ffffff"
        clip: true

        ListView {
            id: lstDayOfTheWeek
            highlightFollowsCurrentItem: true
            preferredHighlightEnd: lstDayOfTheWeek.width/2 + 50
            orientation: ListView.Horizontal
            keyNavigationWraps: false
            anchors.fill: parent
            highlightRangeMode: ListView.StrictlyEnforceRange
            flickableDirection: Flickable.HorizontalFlick
            model: ListModel {
                id: dowModel
                ListElement {
                    dayListElement: "ALL"
                }
                ListElement {
                    dayListElement: "WKDY"
                }
                ListElement {
                    dayListElement: "WKND"
                }
                ListElement {
                    dayListElement: "SUN"
                }
                ListElement {
                    dayListElement: "MON"
                }
                ListElement {
                    dayListElement: "TUE"
                }
                ListElement {
                    dayListElement: "WED"
                }
                ListElement {
                    dayListElement: "THR"
                }
                ListElement {
                    dayListElement: "FRI"
                }
                ListElement {
                    dayListElement: "SAT"
                }
            }
            delegate: Item {
                x: 5
                width: 100
                height: dayOfWeekRect.height
                Text {
                    text: dayListElement
                    //                        font.bold: true
                    font.family: "DejaVu Sans"
                    font.pointSize: elementpointSize - 6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lstDayOfTheWeek.currentIndex=index
                        //                            dayOfWeek = lstDayOfTheWeek.currentIndex
                    }
                }
            }

            preferredHighlightBegin: lstDayOfTheWeek.width/2 - 50
            highlight: Rectangle {
                color: "#fffd78"
                gradient: Gradient {
                    GradientStop {
                        position: 0.00;
                        color: "#9797f8";
                    }
                    GradientStop {
                        position: 1.00;
                        color: "#9cfaf8";
                    }
                }
                border.color: "#ffbe31"
            }
        }
    }
    /// End of dayOfWeekRect

    Spinner {
        id: tmbHour
        y: 42
        width: 42
        height: 141
        color: "#444444"
        gradientColor: "#444444"
        anchors.left: btnAccept.left
        //        focus: true
        model:         ListModel {
            id: hourModel
            ListElement {
                hourListElement: "01"
            }
            ListElement {
                hourListElement: "02"
            }
            ListElement {
                hourListElement: "03"
            }
            ListElement {
                hourListElement: "04"
            }
            ListElement {
                hourListElement: "05"
            }
            ListElement {
                hourListElement: "06"
            }
            ListElement {
                hourListElement: "07"
            }
            ListElement {
                hourListElement: "08"
            }
            ListElement {
                hourListElement: "09"
            }
            ListElement {
                hourListElement: "10"
            }
            ListElement {
                hourListElement: "11"
            }
            ListElement {
                hourListElement: "12"
            }
        }
        itemHeight: 30
        delegate: Text { font.pointSize: elementpointSize; text: hourListElement; height: 30 }
        delegateHighlightSource: "spinner-select.png"
    }
    /// End of tmbHour

    Text {
        id: txtColon
        anchors.verticalCenter: tmbHour.verticalCenter
        anchors.left: tmbHour.right
        text: qsTr(":")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "DejaVu Sans"
        font.pointSize: elementpointSize
    }

    Spinner {
        id: tmbMinute
        y: tmbHour.y
        anchors.left: txtColon.right
        width: 48
        height: tmbHour.height
        gradientColor: "#444444"
        model:         ListModel {
            id: minuteModel
            ListElement {
                minuteListElement: "00"
            }
            ListElement {
                minuteListElement: "05"
            }
            ListElement {
                minuteListElement: "10"
            }
            ListElement {
                minuteListElement: "15"
            }
            ListElement {
                minuteListElement: "20"
            }
            ListElement {
                minuteListElement: "25"
            }
            ListElement {
                minuteListElement: "30"
            }
            ListElement {
                minuteListElement: "35"
            }
            ListElement {
                minuteListElement: "40"
            }
            ListElement {
                minuteListElement: "45"
            }
            ListElement {
                minuteListElement: "50"
            }
            ListElement {
                minuteListElement: "55"
            }
        }
        itemHeight: 30
        delegate: Text { font.pointSize: elementpointSize; text: minuteListElement; height: 30 }
        delegateHighlightSource: "spinner-select.png"

    }
    /// End of tmbMinute

    Spinner {
        id: tmbAP
        y: tmbHour.y
        anchors.left: tmbMinute.right
        anchors.leftMargin: 2
        width: 50
        height: tmbHour.height
        gradientColor: "#444444"
        model:         ListModel {
            id: apModel
            ListElement {
                lstElement: "AM"
            }
            ListElement {
                lstElement: "PM"
            }
        }
        itemHeight: 30
        delegate: Text { font.pointSize: elementpointSize; text: lstElement; height: 30 }
        delegateHighlightSource: "spinner-select.png"
    }
    /// end tmbAP

    Rectangle {
        id: btnCancel
        x: 163
        y: 200
        width: 149
        height: 32
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#626262"
            }
        }

        Text {
            id: cancelText
            x: 56
            y: 18
            text: qsTr("Cancel")
            style: Text.Sunken
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 16
        }

        MouseArea {
            id: cancelMouseArea
            anchors.fill: parent
            onClicked: mainRectangle.showEventListWindow()
        }
    }

    Rectangle {
        id: btnAccept
        x: 8
        y: 200
        width: 149
        height: 32
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#626262"
            }
        }

        Text {
            id: acceptText
            x: 56
            y: 18
            text: qsTr("Accept")
            style: Text.Sunken
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 16
        }

        MouseArea {
            id: acceptMouseArea
            anchors.fill: parent
            onClicked: {
                collectData()
                console.log("sending data:", dayOfWeek, targetTime, lowTemp, hiTemp)
                captureThermostatEventInfo(dayOfWeek, targetTime, lowTemp, hiTemp)
                mainRectangle.showEventListWindow()
            }
        }
    }

    Text {
        id: textLowTemp
        y: 42
        color: "#0066ff"
        text: qsTr("Low Temp")
        anchors.left: tmbAP.right
        anchors.leftMargin: 6
        font.pointSize: 11
    }

    Spinner {
        id: spnLowTemp
        x: 170
        width: 40
        color: "#990000b2"
        gradientColor: "#0000b2"
        anchors.horizontalCenter: textLowTemp.horizontalCenter
        anchors.bottom: tmbHour.bottom
        anchors.top: textLowTemp.bottom
        anchors.topMargin: 3
        model: tempRange
        itemHeight: 30
        delegate: Text { id: lowTempDelegate; font.pointSize: elementpointSize; text: index+tempOffset; height: 30 }
        delegateHighlightSource: "spinner-select-blue.png"
    }

    Text {
        id: txtHighTemp
        y: 43
        color: "#ff0000"
        anchors.bottom: textLowTemp.bottom
        text: qsTr("High Temp")
        anchors.left: textLowTemp.right
        anchors.leftMargin: 9
        font.pointSize: 11
    }

    Spinner {
        id: spnHighTemp
        x: 270
        y: 66
        width: 40
        color: "#99ff0909"
        gradientColor: "#ff0909"
        anchors.horizontalCenter: txtHighTemp.horizontalCenter
        model: tempRange
        anchors.top: spnLowTemp.top
        anchors.bottom: spnLowTemp.bottom
        itemHeight: 30
        delegate: Text { font.pointSize: elementpointSize; text: index+tempOffset; height: 30 }
        delegateHighlightSource: "spinner-select-red.png"

    }



//    Rectangle {
//        id: btnCool

//        property bool checked: false
//        property color onCoolColor: "blue"
//        x: 206
//        y: 42
//        width: 45
//        height: 45
//        color: "#ffffff"
//        gradient: Gradient {
//            GradientStop {
//                position: 0
//                color: "#ffffff"
//            }

//            GradientStop {
//                position: 1
//                color: btnCool.onCoolColor
//            }
//        }
//        MouseArea {
//            id: mouseArea1
//            anchors.fill: parent
//            onClicked: {
//                if( !btnCool.checked) {
//                    tempPosition.state = "CoolingState"
//                    btnCool.state = "Checked"
//                    btnCool.checked = true
//                    btnHeat.checked = false
//                    btnHeat.state = "unChecked"
//                }

//            }
//        }

//        states: [
//            State {
//                name: "Checked"
//                PropertyChanges {
//                    target: btnCool
//                    onCoolColor: "blue"
//                }
//            },
//            State {
//                name: "unChecked"
//                PropertyChanges {
//                    target: btnCool
//                    onCoolColor: "darkgrey"
//                }
//            }
//        ]

//        Text {
//            id: coolText
//            x: 12
//            y: 23
//            text: qsTr("AC")
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignHCenter
//            style: Text.Sunken
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
//            font.pointSize: 16
//        }
//        state: "unChecked"
//    }

//    Rectangle {
//        id: btnHeat

//        property bool checked: true
//        property color onHeatColor: "red"
//        x: 257
//        y: 42
//        width: 45
//        height: 45
//        color: "#ffffff"
//        gradient: Gradient {
//            GradientStop {
//                position: 0
//                color: "#ffffff"
//            }

//            GradientStop {
//                position: 1
//                color: btnHeat.onHeatColor
//            }
//        }
//        MouseArea {
//            id: mouseArea2
//            anchors.fill: parent
//            onClicked: {
//                if( !btnHeat.checked) {
//                    tempPosition.state = "HeatingState"
//                    btnHeat.state = "Checked"
//                    btnHeat.checked = true
//                    btnCool.checked = false
//                    btnCool.state = "unChecked"
//                }
//            }
//        }

//        states: [
//            State {
//                name: "Checked"
//                PropertyChanges {
//                    target: btnHeat
//                    onHeatColor: "red"
//                }
//            },
//            State {
//                name: "unChecked"
//                PropertyChanges {
//                    target: btnHeat
//                    onHeatColor: "darkgrey"
//                }
//            }
//        ]

//        Text {
//            id: heatText
//            x: 12
//            y: 16
//            text: qsTr("Heat")
//            style: Text.Sunken
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignHCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
//            font.pointSize: 14
//        }
//        state: "Checked"
//    }

}


//        Rectangle {
//            id: tmbHour
//            x: 34
//            y: 42
//            width: 42
//            height: 127
//            color: "#19000000"
//            clip: true

//            ListView {
//                id: listviewHour
//                highlightRangeMode: ListView.StrictlyEnforceRange
//                snapMode: ListView.SnapToItem
//                orientation: ListView.Vertical
//                flickableDirection: Flickable.VerticalFlick
//                preferredHighlightBegin: listviewHour.height/2 - 20
//                preferredHighlightEnd: listviewHour.height/2 + 20
//                anchors.fill: parent
//                model:         ListModel {
//                    id: hourModel
//                    ListElement {
//                        hourListElement: "01"
//                    }
//                    ListElement {
//                        hourListElement: "02"
//                    }
//                    ListElement {
//                        hourListElement: "03"
//                    }
//                    ListElement {
//                        hourListElement: "04"
//                    }
//                    ListElement {
//                        hourListElement: "05"
//                    }
//                    ListElement {
//                        hourListElement: "06"
//                    }
//                    ListElement {
//                        hourListElement: "07"
//                    }
//                    ListElement {
//                        hourListElement: "08"
//                    }
//                    ListElement {
//                        hourListElement: "09"
//                    }
//                    ListElement {
//                        hourListElement: "10"
//                    }
//                    ListElement {
//                        hourListElement: "11"
//                    }
//                    ListElement {
//                        hourListElement: "12"
//                    }
//                }

//                delegate: Item {
//                    x: 5
//                    width: parent.width
//                    height: 40
//                    Text {
//                            text: hourListElement
//                            font.family: "DejaVu Sans"
//                            font.pointSize: elementpointSize
//                            anchors.verticalCenter: parent.verticalCenter
//                        }
//                    }
//                highlight: Rectangle {
//                    color: "#fffd78"
//                    gradient: Gradient {
//                        GradientStop {
//                            position: 0.00;
//                            color: "#9797f8";
//                        }
//                        GradientStop {
//                            position: 1.00;
//                            color: "#9cfaf8";
//                        }
//                    }
//                    border.color: "#ffbe31"
//                }
//            }
//        }


//    Rectangle {
//        id: tmbMinute
//        y: tmbHour.y
//        anchors.left: txtColon.right
//        width: 48
//        height: tmbHour.height
//        color: "#19000000"
//        clip: true

//        ListView {
//            id: listViewMinute
//            highlightRangeMode: ListView.StrictlyEnforceRange
//            snapMode: ListView.SnapToItem
//            orientation: ListView.Vertical
//            flickableDirection: Flickable.VerticalFlick
//            preferredHighlightBegin: listViewMinute.height/2 - 20
//            preferredHighlightEnd: listViewMinute.height/2 + 20
//            anchors.fill: parent
//            model:         ListModel {
//                id: minuteModel
//                ListElement {
//                    minuteListElement: "00"
//                }
//                ListElement {
//                    minuteListElement: "05"
//                }
//                ListElement {
//                    minuteListElement: "10"
//                }
//                ListElement {
//                    minuteListElement: "15"
//                }
//                ListElement {
//                    minuteListElement: "20"
//                }
//                ListElement {
//                    minuteListElement: "25"
//                }
//                ListElement {
//                    minuteListElement: "30"
//                }
//                ListElement {
//                    minuteListElement: "35"
//                }
//                ListElement {
//                    minuteListElement: "40"
//                }
//                ListElement {
//                    minuteListElement: "45"
//                }
//                ListElement {
//                    minuteListElement: "50"
//                }
//                ListElement {
//                    minuteListElement: "55"
//                }
//            }

//            delegate: Item {
//                x: 5
//                width: parent.width
//                height: 40
//                Text {
//                    text: minuteListElement
//                    font.family: "DejaVu Sans"
//                    font.pointSize: elementpointSize
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }
//            highlight: Rectangle {
//                color: "#fffd78"
//                gradient: Gradient {
//                    GradientStop {
//                        position: 0.00;
//                        color: "#9797f8";
//                    }
//                    GradientStop {
//                        position: 1.00;
//                        color: "#9cfaf8";
//                    }
//                }
//                border.color: "#ffbe31"
//            }
//        }
//    }

//    Rectangle {
//        id: tmbAP
//        y: tmbHour.y
//        anchors.left: tmbMinute.right
//        width: 50
//        height: tmbHour.height
//        color: "#19ffffff"
//        clip: true
//        ListView {
//            id: listviewAP
//            highlightRangeMode: ListView.StrictlyEnforceRange
//            snapMode: ListView.SnapToItem
//            orientation: ListView.Vertical
//            flickableDirection: Flickable.VerticalFlick
//            preferredHighlightBegin: listviewAP.height/2 - 20
//            preferredHighlightEnd: listviewAP.height/2 + 20
//            anchors.fill: parent
//            model:         ListModel {
//                id: apModel
//                ListElement {
//                    lstElement: "AM"
//                }
//                ListElement {
//                    lstElement: "PM"
//                }
//            }

//            delegate: Item {
//                x: 5
//                width: parent.width
//                height: 40
//                Text {
//                    text: lstElement
//                    font.family: "DejaVu Sans"
//                    font.pointSize: elementpointSize
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }
//            highlight: Rectangle {
//                color: "#fffd78"
//                gradient: Gradient {
//                    GradientStop {
//                        position: 0.00;
//                        color: "#9797f8";
//                    }
//                    GradientStop {
//                        position: 1.00;
//                        color: "#9cfaf8";
//                    }
//                }
//                border.color: "#ffbe31"
//            }
//        }
//    }
