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

FocusScopeItem {
    id: root

    // Common Public API
    property alias placeholderText: placeholder.text
    property alias inputMethodHints: textInput.inputMethodHints
    property alias font: textInput.font
    property alias cursorPosition: textInput.cursorPosition
    property alias readOnly: textInput.readOnly
    // TODO FIX: when new enum available
    property alias echoMode: textInput.echoMode
    property alias acceptableInput: textInput.acceptableInput
    property alias inputMask: textInput.inputMask
    property alias validator: textInput.validator
    property alias selectedText: textInput.selectedText
    property alias selectionEnd: textInput.selectionEnd
    property alias selectionStart: textInput.selectionStart
    property alias text: textInput.text

    function copy() {
        textInput.copy()
    }

    function paste() {
        textInput.paste()
    }

    function cut() {
        textInput.cut()
    }

    function select(start, end) {
        textInput.select(start, end)
    }

    function selectAll() {
        textInput.selectAll()
    }

    function selectWord() {
        textInput.selectWord()
    }

    function positionAt(x) {
        return textInput.positionAt(mapToItem(textInput, x, 0).x)
    }

    function positionToRectangle(pos) {
        var rect = textInput.positionToRectangle(pos)
        rect.x = mapFromItem(textInput, rect.x, 0).x
        return rect;
    }

    // API extensions
    implicitWidth: 2 * platformStyle.paddingMedium +
                   Math.max(privateStyle.textWidth(text, textInput.font), priv.minWidth)

    implicitHeight: 2 * platformStyle.paddingMedium +
                    privateStyle.fontHeight(textInput.font)

    // Private data
    QtObject {
        id: priv
        // Minimum width is either placeholder text lenght or 5 spaces on current font.
        // Using placeholder text lenght as minimum width prevents implicit sized item from
        // shrinking on focus gain.
        property real minWidth: placeholder.text ? privateStyle.textWidth(placeholder.text, textInput.font)
                                                 : privateStyle.textWidth("     ", textInput.font)
    }

    BorderImage {
        id: frame
        anchors.fill: parent
        source: privateStyle.imagePath(textInput.activeFocus ? "qtg_fr_textfield_highlighted" : "qtg_fr_textfield_editable" )
        border { left: 10; top: 10; right: 10; bottom: 10 }
    }

    TextInput {
        id: textInput; objectName: "textInput"
        anchors {
            fill: parent
            leftMargin: platformStyle.paddingMedium; rightMargin: platformStyle.paddingMedium
            topMargin: platformStyle.paddingMedium; bottomMargin: platformStyle.paddingMedium
        }
        clip: true
        color: platformStyle.colorNormalDark
        focus: true
        font { family: platformStyle.fontFamilyRegular; pixelSize: platformStyle.fontSizeMedium }
        // TODO: Use desktop text selection behaviour for now.
        selectByMouse: true
        selectedTextColor: platformStyle.colorNormalLight
        selectionColor: platformStyle.colorTextSelection
    }

    Text {
        id: placeholder; objectName: "placeholder"
        anchors {
            fill: parent
            leftMargin: platformStyle.paddingMedium; rightMargin: platformStyle.paddingMedium
            topMargin: platformStyle.paddingMedium; bottomMargin: platformStyle.paddingMedium
        }
        color: platformStyle.colorNormalMid
        font: textInput.font
        visible: !textInput.activeFocus && !textInput.text && text
    }
}
