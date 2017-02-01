import QtQuick 1.1
import "content"

Rectangle {
    id: eventListWin
    objectName: "eventListWin"

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

    opacity: 0

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    property int fontSize: 14

    function fadeIn() {
        fadeInAnimation.start()
    }

    function setCurrentWeatherIcon() {} // blank, but here so console doesn't complain

    function daySelected(dayText) {
        console.log(dayText)
        btnAllDays.state="UnPressed"
        btnSunday.state="UnPressed"
        btnMonday.state="UnPressed"
        btnTuesday.state="UnPressed"
        btnWednesday.state="UnPressed"
        btnThursday.state="UnPressed"
        btnFriday.state="UnPressed"
        btnSaturday.state="UnPressed"
        if(dayText===btnAllDays.lblText)
            btnAllDays.state="Selected"
        if(dayText===btnSunday.lblText)
            btnSunday.state="Selected"
        if(dayText===btnMonday.lblText)
            btnMonday.state="Selected"
        if(dayText===btnTuesday.lblText)
            btnTuesday.state="Selected"
        if(dayText===btnWednesday.lblText)
            btnWednesday.state="Selected"
        if(dayText===btnThursday.lblText)
            btnThursday.state="Selected"
        if(dayText===btnFriday.lblText)
            btnFriday.state="Selected"
        if(dayText===btnSaturday.lblText)
            btnSaturday.state="Selected"

        sortByDay(dayText)
    }

    signal sortByDay(string dayText)
    signal deleteItem(int row)

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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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
            onClicked: daySelected(lblText)
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

        delegate: ThermoEventListDelegate {}
//        delegate: Item {
//            width: eventListWin.width
//            height: 40
//            Text {
//                text: index
//                anchors.left: parent.left
//                width: 15
//            }
//            Text {
//               text:   eventDayOfWeek
//            }
//            Text {
//                text:   eventTime
//            }

//            MouseArea{
//                anchors.fill: parent
//                onPressAndHold: {
//                    console.log(index, "pressed")
//                }
//                onClicked: {
//                    eventListView.currentIndex=index
//                }
//            }

//            Text {
//                anchors.top: parent.top
//                anchors.bottom: parent.bottom
//                anchors.left: parent.left
//                width: 60
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
            onClicked: {
                deleteItem(eventListView.currentIndex)
            }
        }
    }
}
