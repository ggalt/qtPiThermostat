import QtQuick 1.1

Rectangle {
    id: threePositionSwitch
    width: 100
    height: 62

    property color firstStateColor: "#000000"
    property color secondStateColor: "#000000"
    property color thirdStateColor: "#000000"

    property string firstStateText: "first"
    property string secondStateText: "second"
    property string thirdStateText: "third"

    gradient: Gradient {
        id: buttonGradient
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            id: bottomGradientColor
            position: 1
            color: "#000000"
        }
    }

    Text {
        id: labelText
        x: 31
        y: 24
        text: qsTr("Text")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
    }
    states: [
        State {
            name: "State1"
            PropertyChanges {
                target: bottomGradientColor
                color: "#1afe68"
            }
            PropertyChanges {
                target: labelText
                text: "first"
            }

            PropertyChanges {
                target: threePositionSwitch
                color: "#1cfe69"
            }
        },
        State {
            name: "State2"
            PropertyChanges {
                target: bottomGradientColor
                color: "#ccff00"
            }
            PropertyChanges {
                target: labelText
                text:   secondStateText
            }
        },
        State {
            name: "State3"
            PropertyChanges {
                target: bottomGradientColor
                color: "#ff0000"
            }
            PropertyChanges {
                target: labelText
                text:   thirdStateText
            }
        }
    ]
}
