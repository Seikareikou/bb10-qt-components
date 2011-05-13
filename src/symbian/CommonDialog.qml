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
import "." 1.0

Dialog {
    id: root

    property alias titleText: titleTextArea.text
    property bool privateCloseIcon: false

    title: Item {
        anchors.fill: parent

        Text {
            id: titleTextArea

            anchors {
                left: parent.left
                leftMargin: platformStyle.paddingLarge
                right: iconMouseArea.left
                top: parent.top
                bottom: parent.bottom
            }

            font {
                family: platformStyle.fontFamilyRegular
                pixelSize: platformStyle.fontSizeLarge
            }
            color: platformStyle.colorNormalLink
            clip: true
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id: iconMouseArea
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            width: privateCloseIcon ? 2 * platformStyle.paddingLarge + platformStyle.graphicSizeSmall : 0
            onPressed: privateStyle.play(Symbian.BasicButton)
            onClicked: root.reject()

            Loader {
                id: iconLoader
                anchors.centerIn: parent
                sourceComponent: privateCloseIcon ? closeIconComponent : undefined
            }

            Component {
                id: closeIconComponent

                Image {
                    sourceSize.height: platformStyle.graphicSizeSmall
                    sourceSize.width: platformStyle.graphicSizeSmall
                    smooth: true
                    source: privateStyle.imagePath(iconMouseArea.pressed && iconMouseArea.containsMouse
                        ? "qtg_graf_popup_close_pressed"
                        : "qtg_graf_popup_close_normal")
                }
            }
        }
    }
}
