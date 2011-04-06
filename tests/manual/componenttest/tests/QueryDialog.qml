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
import com.nokia.symbian 1.0

Item {
    id: root
    anchors.fill: parent

    CheckBox {
        id: checkBox
        text: "Icon"
        anchors { bottom: button.top; bottomMargin: 15; horizontalCenter: parent.horizontalCenter }
    }

    Button {
        id: button
        anchors.centerIn: parent
        width: parent.width - parent.spacing
        text: "Open Query Dialog"
        onClicked: queryDialog.open()
    }

    Text {
        id: text
        color: "white"
        anchors { top: button.bottom; topMargin: 20; horizontalCenter: parent.horizontalCenter }
        font.pixelSize: 30
    }

    QueryDialog {
        id: queryDialog

        icon: checkBox.checked ? "qrc:tb_plus.png" : ""
        titleText: "Query Dialog"
        message: "Lorem ipsum dolor sit amet, consectetur adipisici elit,"
                 + "sed eiusmod tempor incidunt ut labore et dolore magna aliqua."
                 + "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris"
                 + "nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit"
                 + "in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
                 + "Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui"
                 + "officia deserunt mollit anim id est laborum."

        acceptButtonText: "Ok"
        rejectButtonText: "Cancel"

        onAccepted: { text.text = "Ok clicked" }
        onRejected: { text.text = "Cancel clicked" }
    }
}
