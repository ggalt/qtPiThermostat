import QtQuick 1.1
import "qrc:components"


Rectangle {
    id: rectangle1
    width: 320
    height: 240

    opacity: 1

    property int elementPixelSize: 36


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

    Rectangle {
        id: tmbHour
        x: 40
        y: 31
        width: 40
        height: 127
        clip: false
        ListModel {
            id: hourModel
            ListElement {
                hourListElement: " 1"
            }
            ListElement {
                hourListElement: " 2"
            }
            ListElement {
                hourListElement: " 3"
            }
            ListElement {
                hourListElement: " 4"
            }
            ListElement {
                hourListElement: " 5"
            }
            ListElement {
                hourListElement: " 6"
            }
            ListElement {
                hourListElement: " 7"
            }
            ListElement {
                hourListElement: " 8"
            }
            ListElement {
                hourListElement: " 9"
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

        ListView {
            id: listviewHour
            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            highlightFollowsCurrentItem: true
            keyNavigationWraps: false
            anchors.fill: parent
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            model: hourModel
            delegate: Text {
                    text: hourListElement
                    font.family: "DejaVu Sans"
                    font.pixelSize: elementPixelSize
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listviewHour.currentIndex=index
                        }
                    }
            }
            highlight: Rectangle { color: "lightsteelblue"; radius: 5; focus: true }
        }
    }

    Rectangle {
        id: tmbMinutes
        x: 80
        y: 31
        width: 52
        height: 127
        ListModel {
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

        ListView {
            id: listviewMinute
            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            anchors.fill: parent
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            model: minuteModel
            delegate: Text {
                    text: minuteListElement
                    font.family: "DejaVu Sans"
                    font.pixelSize: elementPixelSize
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listviewMinute.currentIndex=index
                        }
                    }
            }
            highlight: Rectangle { color: "lightsteelblue"; radius: 5; focus: true }
        }
    }

    Rectangle {
        id: tmbAP
        x: 138
        y: 31
        width: 56
        height: 86
        ListModel {
            id: myModel
            ListElement {
                lstElement: "AM"
            }
            ListElement {
                lstElement: "PM"
            }
        }

        ListView {
            id: listviewAP
            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            anchors.fill: parent
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            model: myModel
            delegate: Text {
                    text: lstElement
                    font.pixelSize: elementPixelSize
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listviewAP.currentIndex=index
                        }
                    }
            }
            highlight: Rectangle { color: "lightsteelblue"; radius: 5; focus: false }        }
    }

    Rectangle {
        id: tempSlider
        x: 45
        y: 164
        width: 256
        height: 19
        anchors.horizontalCenter: parent.horizontalCenter
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#000000"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }

        property int value: 30
        property int maxValue: 99
        property int minValue: 40

        Rectangle {
            id: tempPosition
            property double tempStep: (tempSlider.width)/(tempSlider.maxValue-tempSlider.minValue)
            property color slideColor: "red"

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

            width: tempSlider.width - (tempStep*tempSlider.value)
            color: "#ff1414"
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
        property string targetTemp: tempSlider.value.toLocaleString()
        x: 238
        y: 100
        text: targetTemp
        font.pixelSize: 50
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
            font.pixelSize: 20
        }

        MouseArea {
            id: cancelMouseArea
            anchors.fill: parent

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
            font.pixelSize: 20
        }

        MouseArea {
            id: acceptMouseArea
            anchors.fill: parent
        }
    }

    Text {
        property string degreeMarkString: String.fromCharCode(176)
        id: degreeMark
        y: targetTempText.y
        text: degreeMarkString
        anchors.left: targetTempText.right
        anchors.leftMargin: 0
        font.pixelSize: 50
    }

    Rectangle {
        id: btnCool

        property bool checked: false
        property color onCoolColor: "blue"
        x: 207
        y: 32
        width: 45
        height: 45
        color: "#ffffff"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: btnCool.onCoolColor
            }
        }
        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: {
                if( !btnCool.checked) {
                    tempPosition.state = "CoolingState"
                    btnCool.state = "Checked"
                    btnCool.checked = true
                    btnHeat.checked = false
                    btnHeat.state = "unChecked"
                } else {
                    tempPosition.state = "HeatingState"
                    btnCool.state = "unChecked"
                    btnCool.checked = false
                    btnHeat.checked = true
                    btnHeat.state = "Checked"
                }

            }
        }

        states: [
            State {
                name: "Checked"
                PropertyChanges {
                    target: btnCool
                    onCoolColor: "blue"
                }
            },
            State {
                name: "unChecked"
                PropertyChanges {
                    target: btnCool
                    onCoolColor: "darkgrey"
                }
            }
        ]

        Text {
            id: coolText
            x: 12
            y: 23
            text: qsTr("AC")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            style: Text.Sunken
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }
        state: "unChecked"
    }

    Rectangle {
        id: btnHeat

        property bool checked: true
        property color onHeatColor: "red"
        x: 258
        y: 32
        width: 45
        height: 45
        color: "#ffffff"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: btnHeat.onHeatColor
            }
        }
        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            onClicked: {
                if( !btnHeat.checked) {
                    tempPosition.state = "HeatingState"
                    btnHeat.state = "Checked"
                    btnHeat.checked = true
                    btnCool.checked = false
                    btnCool.state = "unChecked"
                } else {
                    tempPosition.state = "CoolingState"
                    btnHeat.state = "unChecked"
                    btnHeat.checked = false
                    btnCool.checked = true
                    btnCool.state = "Checked"
                }
            }
        }

        states: [
            State {
                name: "Checked"
                PropertyChanges {
                    target: btnHeat
                    onHeatColor: "red"
                }
            },
            State {
                name: "unChecked"
                PropertyChanges {
                    target: btnHeat
                    onHeatColor: "darkgrey"
                }
            }
        ]

        Text {
            id: heatText
            x: 12
            y: 16
            text: qsTr("Heat")
            style: Text.Sunken
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }
        state: "Checked"
    }
}
