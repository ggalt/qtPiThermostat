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
    property int targetTemp: 40
    property bool isHeat: true

    property string txthour: ""
    property string txtminute: ""
    property string txtmeridiem: ""


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

    function collectData() {
        dayOfWeek = dowModel.get(lstDayOfTheWeek.currentIndex).dayListElement
        // no need to get targetTemp because slider sets it directly
        // targetTemp = targetTemp
        txthour = hourModel.get(tmbHour.currentIndex).hourListElement
        txtminute = minuteModel.get(tmbMinute.currentIndex).minuteListElement
        txtmeridiem = apModel.get(tmbAP.currentIndex).lstElement
        targetTime = txthour + ":" + txtminute + " " + txtmeridiem
        isHeat = modeSwitch.mode
        console.log("collectData() :", dayOfWeek, targetTime, targetTemp, "Heat =", isHeat)
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
        x: 34
        y: 42
        width: 42
        height: 127
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
    }
    /// End of tmbMinute

    Spinner {
        id: tmbAP
        y: tmbHour.y
        anchors.left: tmbMinute.right
        anchors.leftMargin: 2
        width: 50
        height: tmbHour.height
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
    }
    /// end tmbAP

    Rectangle {
        id: tempSlider
        x: 45
        y: 175
        width: 256
        height: 19
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }

        property alias value: thermoEventRect.targetTemp
        property int maxValue: 99
        property int minValue: 40

        Rectangle {
            id: tempPosition
            property double tempStep: (tempSlider.width)/(tempSlider.maxValue-tempSlider.minValue)
            property color slideColor: "red"

            width: tempSlider.width - (tempStep*tempSlider.value)
            states: [
                State {
                    name: "CoolingState"
                    PropertyChanges {
                        target: tempPosition
                        slideColor: "blue"
                    }
                },
                State {
                    name: "HeatingState"
                    PropertyChanges {
                        target: tempPosition
                        slideColor: "red"
                    }
                }
            ]

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "white"
                }

                GradientStop {
                    position: 1
                    color: tempPosition.slideColor
                }
            }
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: parent.left
            state: { modeSwitch.mode ? "HeatingState" : "CoolingState" }
        }
        MouseArea {
            id: dragableSlider
            anchors.fill: parent
            onReleased: {
                tempSlider.value = (mouseX * (tempSlider.maxValue - tempSlider.minValue) / tempSlider.width) + tempSlider.minValue
            }
            onMousePositionChanged: {
                if(dragableSlider.containsMouse) {
                    tempPosition.width = mouseX
                    tempSlider.value = (mouseX * (tempSlider.maxValue - tempSlider.minValue) / tempSlider.width) + tempSlider.minValue
                }
            }
        }
    }

    Text {
        id: targetTempText
        property string strTargetTemp: tempSlider.value.toLocaleString()
        x: 230
        y: 111
        text: strTargetTemp
        anchors.bottom: tempSlider.top
        font.pointSize: 44
    }

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
                captureThermostatEventInfo(dayOfWeek, targetTime, targetTemp, isHeat)
                mainRectangle.showEventListWindow()
            }
        }
    }

    Text {
        property string degreeMarkString: String.fromCharCode(176)
        id: degreeMark
        y: targetTempText.y
        text: degreeMarkString
        anchors.left: targetTempText.right
        anchors.leftMargin: 0
        font.pointSize: 30
    }

    Rectangle {
        id: modeSwitch
        x: 207
        y: 60
        width: 81
        height: 38
        color: "#00000000"
        property alias mode: theSwitch.on
        Switch {
            id: theSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.fill: parent
            on: false
            onStateChanged: { on ? tempPosition.state = "CoolingState" : tempPosition.state = "HeatingState" }
        }
    }

    Text {
        id: textAC
        x: 195
        y: 42
        text: qsTr("AC")
        anchors.horizontalCenter: modeSwitch.left
        anchors.bottom: modeSwitch.top
        anchors.bottomMargin: 0
        font.pointSize: 15
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignLeft
    }

    Text {
        id: textHeat
        x: 278
        y: 46
        text: qsTr("HEAT")
        anchors.horizontalCenter: modeSwitch.right
        anchors.bottom: modeSwitch.top
        anchors.bottomMargin: 0
        font.pointSize: 15
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignRight
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
