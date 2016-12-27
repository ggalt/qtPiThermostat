import QtQuick 1.1

Rectangle {
    id: colorCheckButton
    state: "Checked"
    property bool checked
    property color checkedColor: "blue"
    property color uncheckedColor: "lightgray"
    property color pressedColor: "white"
    property color labelColor: "black"
    property string lblText: ""
    border.width: 1
    border.color: "gray"
    function changeCheckedStatus(newStatus) {
        if( newStatus == true ) {
            colorCheckButton.state = "Checked"
        } else {
            colorCheckButton.state = "UnChecked"
        }
    }

    states: [
        State {
            name: "Checked"
            PropertyChanges {
                target: colorCheckButton
                color: "#16ff64"
                checked: true
            }
            PropertyChanges {
                target: colorCheckButton
                color: checkedColor
            }
        },
        State {
            name: "UnChecked"
            PropertyChanges {
                target: colorCheckButton
                checked: false
            }
            PropertyChanges {
                target: colorCheckButton
                color: uncheckedColor
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: colorCheckButton
                color: pressedColor
            }
            PropertyChanges {
                target: colorCheckButton
                checked: checked
            }
        }
    ]

    MouseArea {
        anchors.fill: parent
        onPressed: colorCheckButton.state = "Pressed"
        onReleased: {
                colorCheckButton.state = "Checked"
        }
        Label {
            id: label1
            text: colorCheckButton.lblText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
