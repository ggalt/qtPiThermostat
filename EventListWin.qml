import QtQuick 1.1

Rectangle {
    id: eventListWin
    objectName: "eventListWin"

    opacity: 0

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    function fadeIn() {
        fadeInAnimation.start()
    }

    width: 320
    height: 240
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#0fff6f"
        }

        GradientStop {
            position: 1
            color: "#62c288"
        }
    }

    Rectangle {
        id: dayToolBar
        height: 30
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        gradient: Gradient {
            id: dayToolBarGradient
            GradientStop {
                position: 0
                color: "#0dff6e"
            }

            GradientStop {
                position: 1
                color: "#62c288"
            }
        }

        Text {
            id: btnSunday
            width: 40
            height: dayToolBar.height
            text: qsTr("SU")
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12

            MouseArea {
                id: maBtnSunday
                anchors.fill: parent
            }
        }

        Text {
            id: btnMonday
            width: 40
            height: dayToolBar.height
            text: qsTr("MO")
            anchors.left: btnSunday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnMonday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: btnTuesday
            width: 40
            height: dayToolBar.height
            text: qsTr("TU")
            anchors.left: btnMonday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnTuesday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: btnWednesday
            width: 40
            height: dayToolBar.height
            text: qsTr("WE")
            anchors.left: btnTuesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnWednesday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: btnThursday
            width: 40
            height: dayToolBar.height
            text: qsTr("TH")
            anchors.left: btnWednesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnThursday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: btnFriday
            width: 40
            height: dayToolBar.height
            text: qsTr("FR")
            anchors.left: btnThursday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnFriday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: btnSaturday
            width: 40
            height: dayToolBar.height
            text: qsTr("SA")
            anchors.left: btnFriday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnSaturday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

//        Image {
//            id: backButton
//            width: 40
//            height: dayToolBar.height
//            source: "../icons/backArrow.png"
//            fillMode: Image.Stretch
//            anchors.left: parent.left
//            anchors.top: parent.top

//            MouseArea {
//                id: maBackButton
//                anchors.fill: parent
//                onClicked: mainRectangle.showMainWindow()
//            }
//        }
    }

//    ListModel {
//        id: eventListModel
//        ListElement {
//            name: "Grey"
//            colorCode: "grey"
//        }

//        ListElement {
//            name: "Red"
//            colorCode: "red"
//        }

//        ListElement {
//            name: "Blue"
//            colorCode: "blue"
//        }

//        ListElement {
//            name: "Green"
//            colorCode: "green"
//        }
//    }

    ListView {
        id: eventListView
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: dayToolBar.bottom
        model: eventListModel

        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                spacing: 10
            }
            MouseArea {
                anchors.fill: parent
                onClicked: mainRectangle.showThermoEventWindow()
            }
        }
    }

    Rectangle {
        id: buttonBar
        height: 30
        color: "#ffffff"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        gradient: Gradient {
            id: buttonBarGradient
            GradientStop {
                position: 0
                color: "#0dff6e"
            }

            GradientStop {
                position: 1
                color: "#62c288"
            }
        }

        Text {
            id: btnBack
            width: 100
            color: "#000000"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            text: qsTr("BACK")

            MouseArea {
                id: btnBackMouseArea
                anchors.fill: parent
                onClicked: mainRectangle.showMainWindow()
            }
        }

        Text {
            id: btnAddEntry
            width: 100
            color: "#000000"
            anchors.left: btnBack.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            text: qsTr("ADD")

            MouseArea {
                id: btnAddEntryMouseArea
                anchors.fill: parent
                onClicked: mainRectangle.showThermoEventWindow()
            }
        }

        Text {
            id: btnDeleteEntry
            color: "#000000"
            anchors.right: parent.right
            anchors.left: btnAddEntry.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            text: qsTr("DELETE")

            MouseArea {
                id: btnDeleteEntryMouseArea
                anchors.fill: parent
            }
        }
    }
}
