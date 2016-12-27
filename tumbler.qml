import QtQuick 1.1

Rectangle {
    id: tumbler

    property var elementList: [{"element":"1"},
                                {"element":"2"},
                                {"element":"3"},
                                {"element":"4"},
                                {"element":"5"},
                                {"element":"6"},
                                {"element":"7"},
                                {"element":"8"},
                                {"element":"9"},
                                {"element":"10"},
                                {"element":"11"},
                               {"element":"12"}]

//    ListModel {
//        id: myModel
//        ListElement {
//            lstElement: " 1"
//        }
//        ListElement {
//            lstElement: " 2"
//        }
//        ListElement {
//            lstElement: " 3"
//        }
//        ListElement {
//            lstElement: " 4"
//        }
//        ListElement {
//            lstElement: " 5"
//        }
//        ListElement {
//            lstElement: " 6"
//        }
//        ListElement {
//            lstElement: " 7"
//        }
//        ListElement {
//            lstElement: " 8"
//        }
//        ListElement {
//            lstElement: " 9"
//        }
//        ListElement {
//            lstElement: "10"
//        }
//        ListElement {
//            lstElement: "11"
//        }
//        ListElement {
//            lstElement: "12"
//        }
//    }

    ListView {
        id: listview
        flickableDirection: Flickable.VerticalFlick
        model: elementList

        delegate: Text {
            text: elementList[index].element
        }
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }
}
