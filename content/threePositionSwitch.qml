import QtQuick 1.1

Rectangle {
    id: threePositionSwitch

    property int stateCounter: 0
    state: "State1"

    property color standardTopColor: "#ffffff"
    property color firstStateColor: "#1cfe69"
    property color secondStateColor: "#ccff00"
    property color thirdStateColor: "#ff0000"
    property color pressedTopColor: "#000000"
    property color pressedBottomColor: "#ffffff"

    property string firstStateText: "first"
    property string secondStateText: "second"
    property string thirdStateText: "third"

    function nextState() {
        stateCounter++
        if(stateCounter >= 3)
            stateCounter = 0
        if(stateCounter === 0)
            threePositionSwitch.state = "State1"
        else if(stateCounter === 1)
            threePositionSwitch.state = "State2"
        else if(stateCounter === 2)
            threePositionSwitch.state = "State3"
    }

    gradient: Gradient {
        id: buttonGradient
        GradientStop {
            id: topGradientColor
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
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        onPressed: threePositionSwitch.state = "pressedState"
        onClicked: nextState()
    }
    states: [
        State {
            name: "State1"
            PropertyChanges {
                target: topGradientColor
                color: standardTopColor
            }
            PropertyChanges {
                target: bottomGradientColor
                color: firstStateColor
            }
            PropertyChanges {
                target: labelText
                text:   firstStateText
            }
        },
        State {
            name: "State2"
            PropertyChanges {
                target: topGradientColor
                color: standardTopColor
            }
            PropertyChanges {
                target: bottomGradientColor
                color: secondStateColor
            }
            PropertyChanges {
                target: labelText
                text:   secondStateText
            }
        },
        State {
            name: "State3"
            PropertyChanges {
                target: topGradientColor
                color: standardTopColor
            }
            PropertyChanges {
                target: bottomGradientColor
                color: thirdStateColor
            }
            PropertyChanges {
                target: labelText
                text:   thirdStateText
            }
        },
        State {
            name: "pressedState"
            PropertyChanges {
                target: topGradientColor
                color: pressedTopColor
            }
            PropertyChanges {
                target: bottomGradientColor
                color: pressedBottomColor
            }
            PropertyChanges {
                target: labelText
                text:   labelText.text
            }
        }
    ]
}
