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

import QtQuick 1.0
import com.nokia.symbian 1.0

Item {

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        CheckBox {
            id: checkBox1
            width: parent.width

            Rectangle {
                z: -1
                anchors.fill: parent
                color: "#00000000"
                border.color: "red"
            }

            Rectangle {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                width: parent.implicitWidth
                height: parent.implicitHeight
                color: "#00000000"
                border.color: "blue"
            }
        }

        CheckBox {
            id: checkBox2
            width: checkBox1.width
            text: "checkBox2"
            checked: true

             Rectangle {
                z: -1
                anchors.fill: parent
                color: "#00000000"
                border.color: "red"
            }

            Rectangle {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                width: parent.implicitWidth
                height: parent.implicitHeight
                color: "#00000000"
                border.color: "blue"
            }
        }

        CheckBox {
            id: checkBox3
            width: checkBox2.width
            enabled: checkBox2.checked
            text: checkBox2.checked ? "enabled" : "disabled"
        }
    }
}
