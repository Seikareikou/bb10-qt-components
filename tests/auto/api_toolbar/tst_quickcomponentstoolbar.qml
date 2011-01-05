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

Item {

    ToolBar {
        id: toolbar
    }

    ToolBarLayout {
        id: commonToolsA
        visible: false
        objectName: "toolsA"
        ToolItem { iconId: "icon-m-toolbar-home"; }
        ToolItem { iconId: "icon-m-toolbar-view-menu"; }
        ToolItem { iconId: "icon-m-toolbar-back"; }
    }

    ToolBarLayout {
        id: commonToolsB
        visible: false
        objectName: "toolsB"
        ToolItem { iconId: "icon-m-toolbar-home"; }
        ToolItem { iconId: "icon-m-toolbar-view-menu"; }
        ToolItem { iconId: "icon-m-toolbar-back"; }
    }

    function setToolsA()
    {
        toolbar.setTools(commonToolsA);
    }

    function setToolsB()
    {
        toolbar.setTools(commonToolsB);
    }

    property string currentToolsName: toolbar.tools==undefined? "undefined":toolbar.tools.objectName

}
