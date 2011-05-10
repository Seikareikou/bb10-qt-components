/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

//![0]
import QtQuick 1.0
import Qt.labs.components.native 1.0

Window {
    id: window

    Item {
        anchors.fill: parent

        Component {
            id: gameViewComponent

            GameView {
                configuration: customLoader.item
            }
        }

        Loader {
            id: gameViewLoader

            anchors.fill: parent
        }

        Text {
            id: errorText

            color: "white"
            anchors.centerIn: parent
            visible: errorText.text.length > 0
            text: ""
        }

        MouseArea {
            anchors.fill: parent
            enabled: errorText.visible
            onClicked: Qt.quit()
        }
    }

    CustomLoader {
        id: customLoader

        path: "configurations"
        fileName: "Configuration.qml"
        windowWidth: window.width
        windowHeight: window.height

        onLoaded: gameViewLoader.sourceComponent = gameViewComponent;
        onLoadError: errorText.text = "Error: unable to load configuration\nTap to quit.";
    }

    Binding {
        target: customLoader.item
        property: "inPortrait"
        value: window.inPortrait
    }

    Component.onCompleted: customLoader.load()
}
//![0]
