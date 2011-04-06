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

import Qt 4.7
import com.meego 1.0

Page {

    property alias infoText: infoLabel.text
    property alias data: leftContainer.data
    property alias flickableContentHeight: flick.contentHeight

    Flickable {
        id: flick

        anchors.fill: parent

        Item {
            id: leftContainer
            anchors.left: parent.left
            anchors.right: separator.left
            anchors.top: separator.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 6
            anchors.bottomMargin: 6
            anchors.leftMargin: 8
            anchors.rightMargin: 10
        }

        Rectangle {
            id: separator
            color: "black"
            width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 16
            anchors.bottomMargin: 5
        }

        Label {
            id: infoLabel
            anchors.left: separator.right
            anchors.right: parent.right
            anchors.top: separator.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 6
            anchors.bottomMargin: 6
            anchors.leftMargin: 10
            anchors.rightMargin: 8
        }
    }

    ScrollDecorator {
        flickable: flick
    }
}
