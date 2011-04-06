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

Window {
    id: root

    Flickable {
        id: flickable
        anchors { left: parent.left; right: parent.right; top: parent.top; bottom: singleRow.top }
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        Item {
            id: leftList
            width: root.width
            height: root.height - singleRow.height

            ListModel {
                id: testModel

                ListElement { name: "A Cat 1"; alphabet: "A" }
                ListElement { name: "A Cat 2"; alphabet: "A" }
                ListElement { name: "A Cat 3"; alphabet: "A" }
                ListElement { name: "A Cat 1"; alphabet: "A" }
                ListElement { name: "A Cat 2"; alphabet: "A" }
                ListElement { name: "A Cat 3"; alphabet: "A" }
                ListElement { name: "Boo 1"; alphabet: "B" }
                ListElement { name: "Boo 2"; alphabet: "B" }
                ListElement { name: "Boo 3"; alphabet: "B" }
                ListElement { name: "Cat 1"; alphabet: "C" }
                ListElement { name: "Cat 2"; alphabet: "C" }
                ListElement { name: "Cat 3"; alphabet: "C" }
                ListElement { name: "Cat 4"; alphabet: "C" }
                ListElement { name: "Cat 5"; alphabet: "C" }
                ListElement { name: "Cat 6"; alphabet: "C" }
                ListElement { name: "Dog 1"; alphabet: "D" }
                ListElement { name: "Dog 2"; alphabet: "D" }
                ListElement { name: "Dog 3"; alphabet: "D" }
                ListElement { name: "Dog 4"; alphabet: "D" }
                ListElement { name: "Dog 5"; alphabet: "D" }
                ListElement { name: "Dog 6"; alphabet: "D" }
                ListElement { name: "Dog 7"; alphabet: "D" }
                ListElement { name: "Dog 8"; alphabet: "D" }
                ListElement { name: "Dog 9"; alphabet: "D" }
                ListElement { name: "Elephant 1"; alphabet: "E" }
                ListElement { name: "Elephant 2"; alphabet: "E" }
                ListElement { name: "Elephant 3"; alphabet: "E" }
                ListElement { name: "Elephant 4"; alphabet: "E" }
                ListElement { name: "Elephant 5"; alphabet: "E" }
                ListElement { name: "Elephant 6"; alphabet: "E" }
                ListElement { name: "FElephant 1"; alphabet: "F" }
                ListElement { name: "FElephant 2"; alphabet: "F" }
                ListElement { name: "FElephant 3"; alphabet: "F" }
                ListElement { name: "FElephant 4"; alphabet: "F" }
                ListElement { name: "FElephant 5"; alphabet: "F" }
                ListElement { name: "FElephant 6"; alphabet: "F" }
                ListElement { name: "Guinea pig"; alphabet: "G" }
                ListElement { name: "Goose"; alphabet: "G" }
                ListElement { name: "Giraffe"; alphabet: "G" }
                ListElement { name: "Guinea pig"; alphabet: "G" }
                ListElement { name: "Goose"; alphabet: "G" }
                ListElement { name: "Giraffe"; alphabet: "G" }
                ListElement { name: "Guinea pig"; alphabet: "G" }
                ListElement { name: "Goose"; alphabet: "G" }
                ListElement { name: "Giraffe"; alphabet: "G" }
                ListElement { name: "Horse"; alphabet: "H" }
                ListElement { name: "Horse"; alphabet: "H" }
                ListElement { name: "Horse"; alphabet: "H" }
                ListElement { name: "Parrot"; alphabet: "P" }
                ListElement { name: "Parrot"; alphabet: "P" }
                ListElement { name: "Parrot"; alphabet: "P" }
                ListElement { name: "Parrot"; alphabet: "P" }
            }

            ListView {
                id: list
                anchors.fill: parent
                delegate:  Rectangle {
                    width: parent.width
                    height: 50  // magic
                    border.color: "#000"
                    border.width: 1
                    color: index % 2 == 0 ? "#ffffff" : "#eeeeee"
                    property string section: name[0]
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 20  // magic
                        text: name + " (index " + index + ")"
                    }
                }

                model: testModel
                section.property: "alphabet"
                section.criteria: ViewSection.FullString
                section.delegate: Rectangle {
                    width: list.width
                    height: 30  // magic
                    color: "#888"
                    Text {
                        objectName: "Label" + section
                        anchors.verticalCenter: parent.verticalCenter
                        x: 5  // magic
                         text: section
                         font.bold: true
                         font.pointSize: 16
                     }
                }
            }

            ScrollDecorator {
                flickableItem: list
            }
        }
    }

    SectionScroller {
        id: sectionScroller
        listView: list
    }

    CheckBox {
        id: singleRow
        text: "Single Row"
        anchors { left: parent.left; bottom: parent.bottom }
        onClicked: sectionScroller.platformSingleRow = !sectionScroller.platformSingleRow
    }
}
