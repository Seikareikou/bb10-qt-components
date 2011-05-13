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
    property int testId: 0
    property int itemCount: 2000
    property int sectionInterval: 0
    property string heading: "Test"
    property alias cacheBuffer: listView.cacheBuffer
    property bool scrollBar: false
    // For TDriver ->
    // Triggers the InitializeModel()
    property bool reInitModel: false

    Component.onCompleted: setupTest(testId)
    onReInitModelChanged: initializeModel()

    BusyIndicator {
        id: busyIndicator
        visible: !listModel.initialized
        running: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 150
        width: 150
    }

    ListView {
        id: listView
        anchors.fill: parent
        opacity: !listModel.initialized ? 0 : 1
        focus: true
        clip: true
        model: ListModel { id: model }
        delegate: textDelegate
        header: heading != "" ? listHeader : null
        section.property: sectionInterval > 0 ? "sectionIdentifier" : ""
        section.delegate: sectionInterval > 0 ? sectionDelegate : null
    }

    // Creates Scrollbar dynamically based on state of scrollBar flag
    Loader {
        sourceComponent: root.scrollBar ? scrollBar : undefined
        anchors { top: listView.top; right: listView.right }
    }

    Component {
        id: scrollBar
        ScrollBar {
            flickableItem: listView
        }
    }

    function setupTest(testid) {
        switch (testid) {
            case 0: {
                root.heading = "ListItems with text"
                listView.delegate = textDelegate
                break
            }
            case 1: {
                root.heading = "ListItems with image"
                listView.delegate = imageDelegate
                break
            }
            case 2: {
                root.heading = "ListItems with image and text"
                listView.delegate = imageAndTextDelegate
                break
            }
            case 3: {
                root.heading = "ListView with multiselection"
                listView.delegate = selectableDelegate
                break
            }
            case 4: {
                root.heading = "ListView with sections"
                root.sectionInterval = 10
                listView.delegate = imageAndTextDelegate
                break
            }
            default:
                console.log("Invalid test setup")
        }
        initializeModel()
    }

    ContextMenu {
        id: contextMenu

        content: MenuLayout {
            MenuItem {
                text: "Set disabled"
                onClicked: listView.model.set(listView.currentIndex, {"disabled": true})
            }
            MenuItem {
                text: "Add item"
                onClicked: createItemDialog.open()
            }
            MenuItem {
                text: "Delete item"
                onClicked: {
                    if (listView.currentIndex >= 0)
                        listView.model.remove(listView.currentIndex)
                }
            }
        }
    }

    Dialog {
        id: createItemDialog
        title: Text {
            text: "Create new list item"
            font { bold: true; pixelSize: 16 }
            color: "white"
            anchors.fill: parent
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
        buttons: Row {
            height: 60
            width: parent.width

            Button {
                text: "Ok"
                width: parent.width / 2
                height: parent.height
                onClicked: createItemDialog.accept()
            }

            Button {
                text: "Cancel"
                width: parent.width / 2
                height: parent.height
                onClicked: createItemDialog.reject()
            }
        }
        content: Column {
            anchors.fill: parent

            Text {
                text: "Enter title"
            }

            TextField {
                id: titleField
                text: "New item - Title"
                width: parent.width
            }

            Text {
                text: "Enter subtitle"
            }

            TextField {
                id: subTitleField
                text: "New item - SubTitle"
                width: parent.width
            }

            Text {
                text: "Select image size"
            }

            ChoiceList {
                id: imageSizeChoiceList
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - parent.spacing
                currentIndex: 0
                model: ["Undefined", "Tiny", "Small", "Medium", "Large"]
            }
        }
        onAccepted: {
            listView.model.insert(listView.currentIndex + 1, {
                "title": titleField.text,
                "subTitle": subTitleField.text,
                "imageSize": root.getSize(imageSizeChoiceList.currentIndex), // Fetch actual size in pixels based on index
                "image": "image://theme/:/list1.png",
                "disabled": false,
                "selected": false,
                "sectionIdentifier": 0} )
        }
    }

    Component {
        id: listHeader

        ListHeading {
            id: listHeader
            width: listView.width

            ListItemText {
                id: txtHeading
                anchors.fill: listHeader.paddingItem
                role: "Heading"
                text: root.heading
            }
        }
    }

    Component {
        id: sectionDelegate

        ListHeading {
            id: sectionHeader
            width: listView.width

            ListItemText {
                id: txtHeading
                anchors.fill: sectionHeader.paddingItem
                role: "Heading"
                text: "Section separator"
            }
        }
    }


    Component {
        id: textDelegate

        ListItem {
            id: listItem2
            objectName: title
            width: listView.width
            enabled: !disabled // State from model

            Column {
                anchors.fill: parent.paddingItem

                ListItemText {
                    mode: listItem2.mode
                    role: "Title"
                    text: title // Title from model
                }

                ListItemText {
                    mode: listItem2.mode
                    role: "SubTitle"
                    text: subTitle // SubTitle from model
                }
            }
            onPressAndHold: contextMenu.open()
        }
    }

    Component {
        id: imageDelegate

        ListItem {
            width: listView.width
            enabled: !disabled // State from model

            Image {
                anchors {
                    left: imageSize == platformStyle.graphicSizeLarge ? parent.left : parent.paddingItem.left
                    top: imageSize == platformStyle.graphicSizeLarge ? parent.top : parent.paddingItem.top
                }
                sourceSize.height: imageSize
                sourceSize.width: imageSize
                source: image
            }
            onPressAndHold: contextMenu.open()
        }
    }

    Component {
        id: imageAndTextDelegate

        ListItem {
            id: listItem3
            objectName: title
            width: listView.width
            enabled: !disabled // State from model


            Image {
                id: imageItem
                anchors {
                    left: imageSize == platformStyle.graphicSizeLarge ? listItem3.left : listItem3.paddingItem.left
                    top: imageSize == platformStyle.graphicSizeLarge ? listItem3.top : listItem3.paddingItem.top
                }
                sourceSize.height: imageSize
                sourceSize.width: imageSize
                source: imageSize == 0 ? "" : image
            }
            Column {
                anchors {
                    top: listItem3.paddingItem.top
                    left: imageItem.right
                    leftMargin: platformStyle.paddingMedium
                    right: listItem3.paddingItem.right
                }

                ListItemText {
                    mode: listItem3.mode
                    role: "Title"
                    text: title // Title from model
                }

                ListItemText {
                    mode: listItem3.mode
                    role: "SubTitle"
                    text: subTitle // SubTitle from model
                }
            }
            onPressAndHold: contextMenu.open()
        }
    }

    Component {
        id: selectableDelegate

        ListItem {
            id: listItem4
            objectName: title
            width: listView.width
            enabled: !disabled // State from model

            Row {
                anchors.fill: listItem4.paddingItem
                spacing: platformStyle.paddingMedium

                Image {
                    sourceSize.height: imageSize
                    sourceSize.width: imageSize
                    source: image
                }

                Column {

                    ListItemText {
                        mode: listItem4.mode
                        role: "Title"
                        text: title // Title from model
                    }

                    ListItemText {
                        mode: listItem4.mode
                        role: "SubTitle"
                        text: subTitle // SubTitle from model
                    }
                }
            }

            CheckBox {
                id: checkbox
                enabled: listItem4.enabled
                checked: selected
                anchors { right: listItem4.paddingItem.right; verticalCenter: listItem4.verticalCenter }
                onClicked: listView.model.set(index, { "selected": checkbox.checked })
            }
            onClicked: {
                checkbox.checked = !checkbox.checked
                listView.model.set(index, { "selected": checkbox.checked })
            }
            onPressAndHold: contextMenu.open()
        }
    }


    ListModel {
        id: listModel
        property bool initialized: false
    }

    WorkerScript {
        id: worker
        source: "listmodelloader.js"
        onMessage: listModel.initialized = true
    }

    function initializeModel() {
        listModel.clear()
        listView.model = listModel
        var msg = { 'listModel': listModel,
            'imageSize': platformStyle.graphicSizeMedium,
            'image': "image://theme/:/list1.png",
            'sectionInterval': sectionInterval,
            'itemCount': root.itemCount
            };
        worker.sendMessage(msg)
    }

    function getSize(size) {
        switch (size) {
            case 1: return platformStyle.graphicSizeTiny; break
            case 2: return platformStyle.graphicSizeSmall; break
            case 3: return platformStyle.graphicSizeMedium; break
            case 4: return platformStyle.graphicSizeLarge; break
            default: return 0
        }
    }
}
