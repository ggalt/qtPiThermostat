/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

/*
  Alterations by george galt
  */

import QtQuick 1.0

Rectangle {
    id: spinnerMain
    property alias model: view.model
    property alias delegate: view.delegate
    property alias currentIndex: view.currentIndex
    property real itemHeight: 20
    property string delegateHighlightSource: ""
    property color gradientColor: "#99ffffff"
    gradient: Gradient {
        GradientStop {
            position: 0.00
            color: gradientColor
        }

        GradientStop {
            position: 0.45
            color: "#00000000"
        }
        GradientStop {
            position: 0.55
            color: "#00000000"
        }
        GradientStop {
            position: 1.00
            color: gradientColor
        }


    }

//    source: "spinner-bg.png"
    clip: true

    PathView {
        id: view
        anchors.fill: parent

        pathItemCount: height/itemHeight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlight: Image {
            id: delegateHighlight;
            source: spinnerMain.delegateHighlightSource
            width: view.width;
            height: itemHeight+4
        }
        dragMargin: view.width/2

        path: Path {
            startX: view.width/2; startY: -itemHeight/2
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            if(mouseY < spinnerMain.height/2)
                view.incrementCurrentIndex()
            else
                view.decrementCurrentIndex()
        }
    }

    Keys.onDownPressed: view.incrementCurrentIndex()
    Keys.onUpPressed: view.decrementCurrentIndex()
}


///****************************************************************************
//**
//** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
//** Contact: http://www.qt-project.org/legal
//**
//** This file is part of the examples of the Qt Toolkit.
//**
//** $QT_BEGIN_LICENSE:BSD$
//** You may use this file under the terms of the BSD license as follows:
//**
//** "Redistribution and use in source and binary forms, with or without
//** modification, are permitted provided that the following conditions are
//** met:
//**   * Redistributions of source code must retain the above copyright
//**     notice, this list of conditions and the following disclaimer.
//**   * Redistributions in binary form must reproduce the above copyright
//**     notice, this list of conditions and the following disclaimer in
//**     the documentation and/or other materials provided with the
//**     distribution.
//**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
//**     of its contributors may be used to endorse or promote products derived
//**     from this software without specific prior written permission.
//**
//**
//** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
//**
//** $QT_END_LICENSE$
//**
//****************************************************************************/

///*
//  Alterations by george galt
//  */

//import QtQuick 1.0

//Image {
//    id: spinnerMain
//    property alias model: view.model
//    property alias delegate: view.delegate
//    property alias currentIndex: view.currentIndex
//    property real itemHeight: 20
//    property string delegateHighlightSource: ""

//    source: "spinner-bg.png"
//    clip: true

//    PathView {
//        id: view
//        anchors.fill: parent

//        pathItemCount: height/itemHeight
//        preferredHighlightBegin: 0.5
//        preferredHighlightEnd: 0.5
//        highlight: Image {
//            id: delegateHighlight;
//            source: spinnerMain.delegateHighlightSource
//            width: view.width;
//            height: itemHeight+4
//        }
//        dragMargin: view.width/2

//        path: Path {
//            startX: view.width/2; startY: -itemHeight/2
//            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
//        }
//    }

//    MouseArea {
//        anchors.fill: parent
//        onPressed: {
//            if(mouseY < spinnerMain.height/2)
//                view.incrementCurrentIndex()
//            else
//                view.decrementCurrentIndex()
//        }
//    }

//    Keys.onDownPressed: view.incrementCurrentIndex()
//    Keys.onUpPressed: view.decrementCurrentIndex()
//}
