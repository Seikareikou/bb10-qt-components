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
import Qt.labs.components.native 1.0

// ~2.46" VGA
Item {
    property alias hugeFont: textForHugeFont.font
    property alias largeFont: textForLargeFont.font
    property alias mediumFont: textForMediumFont.font

    property int marginSize: 10
    property int spacingSize: 7

    property int starIconSize: 30
    property int toneIconSize: 30
    property int starTouchSize: 46
    property int frequencyStripHeight: 76
    property int frequencyButtonSize: 80

    property real consoleRatio: 0.60
    property real stationListRatio: 0.8

    Text {
        id: textForHugeFont
        font.family: "Nokia Sans"
        font.weight: Font.DemiBold
        font.pixelSize: (screen.currentOrientation == Screen.Landscape) ? 64 : 70
    }
    Text {
        id: textForLargeFont
        font.family: "Nokia Sans"
        font.weight: Font.Normal
        font.pixelSize: 30
    }
    Text {
        id: textForMediumFont
        font.family: "Nokia Sans"
        font.weight: Font.Normal
        font.pixelSize: 24
    }
}
