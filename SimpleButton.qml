import QtQuick 1.1

Rectangle {
    id: simpleButton
    state: "UnPressed"
    property string lblText: ""
    property color lightBorder: "#66808080"
    property color darkBorder: "#80333333"
    property color pressedColor: "#66808080"
    property color unpressedColor: "#00000000"
    property color selectedColor: "#4c000000"
    property int fontPointSize: 10
    color: unpressedColor

    signal clicked

    Text {
        id: myText
        text: lblText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: fontPointSize
    }

    Rectangle {
        id: leftBoarder
        width: 1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color:  lightBorder
    }

    Rectangle {
        id: rightBoarder
        width: 1
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color:  darkBorder
    }

    states: [
        State {
            name: "Pressed"
            PropertyChanges {
                target: simpleButton
                color: pressedColor
            }
            PropertyChanges {
                target: leftBoarder
                color: darkBorder
            }
            PropertyChanges {
                target: rightBoarder
                color: lightBorder
            }
        },
        State {
            name: "UnPressed"
            PropertyChanges {
                target: simpleButton
                color: unpressedColor
            }
            PropertyChanges {
                target: leftBoarder
                color: lightBorder
            }
            PropertyChanges {
                target: rightBoarder
                color: darkBorder
            }
        },
        State {
            name: "Selected"
            PropertyChanges {
                target: simpleButton
                color: selectedColor
            }
        }
    ]

    MouseArea {
        id: btnMouseArea
        anchors.fill: parent
        onPressed: simpleButton.state = "Pressed"
        onReleased: simpleButton.state = "UnPressed"
        onClicked:  {
            simpleButton.state = "Selected"
            simpleButton.clicked()
        }
    }
}
