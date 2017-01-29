import QtQuick 1.1
import "content"

Rectangle {
    id: eventListWin
    objectName: "eventListWin"

    property int fontSize: 14

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
            color: "#ffffff"
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

        SimpleButton {
            id: btnAllDays
            width: 40
            height: dayToolBar.height
            lblText: "All"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnSunday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("SU")
            anchors.left: btnAllDays.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnMonday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("MO")
            anchors.left: btnSunday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnTuesday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("TU")
            anchors.left: btnMonday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnWednesday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("WE")
            anchors.left: btnTuesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnThursday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("TH")
            anchors.left: btnWednesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnFriday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("FR")
            anchors.left: btnThursday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

        SimpleButton {
            id: btnSaturday
            width: 40
            height: dayToolBar.height
            lblText: qsTr("SA")
            anchors.left: btnFriday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            fontPointSize: fontSize
        }

    }

    ListView {
        id: eventListView
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: dayToolBar.bottom
        highlight: Image {
            source: "content/listview-select.png"
        }
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: eventListView.height
        clip: true
        model: eventListModel
//        model: 20

        delegate: Item {
            width: eventListWin.width
            height: 40
            Text {
               text:   eventDayOfWeek
//                text: index
            }
            Text {
                text:   eventTime
//                text: index
            }

            MouseArea{
                anchors.fill: parent
                onPressAndHold: {
                    console.log(index, "pressed")
                }
                onClicked: {
                    eventListView.currentIndex=index
                }
            }

//            Text {
//                anchors.top: parent.top
//                anchors.bottom: parent.bottom
//                anchors.left: parent.left
//                width: 60
//            }
        }

//        delegate: Item {
//            x: 5
//            width: 80
//            height: 40
//            Row {
//                id: row1
//                Rectangle {
//                    width: 40
//                    height: 40
//                    color: colorCode
//                }

//                Text {
//                    text: name
//                    font.bold: true
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//                spacing: 10
//            }
//            MouseArea {
//                anchors.fill: parent
//                onClicked: mainRectangle.showThermoEventWindow()
//            }
//        }
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

        SimpleButton {
            id: btnBack
            width: 100
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            fontPointSize: fontSize
            lblText: qsTr("BACK")
            onClicked: mainRectangle.changeAppState("MainWindowState")
        }

        SimpleButton {
            id: btnAddEntry
            width: 100
            anchors.left: btnBack.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            lblText: qsTr("ADD")
            fontPointSize: fontSize
            onClicked: mainRectangle.changeAppState("AddEventState")
        }

        SimpleButton {
            id: btnDeleteEntry
            anchors.right: parent.right
            anchors.left: btnAddEntry.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            lblText: qsTr("DELETE")
            fontPointSize: fontSize
        }
    }
}
