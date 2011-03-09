/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components API Conformance Test Suite.
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
import QtQuickTest 1.0

ComponentTestCase {
    name: "ChoiceList"

    SpecChoiceList {
        id: testSubject
    }

    ListModel {
        id: emptyChoices
    }

    ListModel {
        id: choices

        ListElement { text: "Alpha" }
        ListElement { text: "Beta" }
        ListElement { text: "Gamma" }
        ListElement { text: "Delta" }
    }

    function test_currentIndex() {}
    function test_model() {
        // FIXME: Can't test selection properly here because it depends
        // a lot on layout.

        var message =
            "Setting an empty model should set the currentIndex to -1.";
        obj.model = emptyChoices;
        compare(obj.currentIndex, -1, message);

        var message =
            "Setting model to null should set the currentIndex to -1.";
        obj.model = null;
        compare(obj.currentIndex, -1, message);

        var message =
            "Setting model a valid and non-empty model should set the currentIndex to 0.";
        obj.model = choices;
        compare(obj.currentIndex, 0, message);
    }
}
