/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt 4.7
import com.meego 1.0

// Here we want to use the TextField background. I'm relying on the
// image provider to get that.
BorderImage {
    property alias currentOperation: operation
    property alias text: digits.text

    source: "image://theme/meegotouch-textedit-background";
    border {
        left: 12
        top: 12
        right: 12
        bottom: 12
    }

    // ### Just to steal the font
    TextField {
        id: field
        visible: false
    }

    Text {
        id: digits
        font: field.font
        horizontalAlignment: TextInput.AlignRight
        anchors {
            right: parent.right
            rightMargin: 12
            left: operation.right
            leftMargin: 6
            verticalCenter: parent.verticalCenter
        }
    }

    Text {
        id: operation
        font.bold: true; font.pixelSize: parent.height * .7
        color: "#343434"; smooth: true
        anchors {
            left: parent.left
            leftMargin: 12
            verticalCenter: parent.verticalCenter
        }
    }
}
