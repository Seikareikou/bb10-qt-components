/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
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

Rectangle {
    id: window
    
    width: 854
    height: 480
    
    Image {
        source: "image://theme/meegotouch-applicationpage-background"
    }

    PageStack {
        id: pageStack
        
        toolbar: toolbar
        
        anchors.top: toolbar.bottom
        anchors.bottom: window.bottom
    }
    
    ToolBar {
        id: toolbar
        
        anchors.top: window.top
    }
    
    ToolBarLayout {
        id: commonTools
        visible: false
        ToolItem { iconId: "icon-m-toolbar-home" }
        ToolItem { iconId: "icon-m-toolbar-view-menu" }
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
    }

    Component {
        id: pageComponent

        Page {
            tools: commonTools
            ListView {
                id: list
                anchors.fill: parent
                model: WidgetGallerySections { }
                delegate: BasicListItem {
                    title: name
                    onClicked: {
                        pageStack.push(Qt.createComponent(source));
                    }
                }
            }
            ScrollDecorator {
                flickable: list
            }
        }
    }

    Component.onCompleted: {
        pageStack.push(pageComponent)
    }
}
