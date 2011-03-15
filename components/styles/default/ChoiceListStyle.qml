import QtQuick 1.0

QtObject {
    property int minimumWidth: 200
    property int minimumHeight: 32

    property int leftMargin: 8
    property int topMargin: 8
    property int rightMargin: 34
    property int bottomMargin: 8

    property Component background: Component {
        Item {
            opacity: enabled ? 1 : 0.8
            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.margins: 1
                color: styling.backgroundColor
                radius: 5
            }
            BorderImage {
                anchors.fill: parent
                id: backgroundimage
                smooth: true
                source: styledItem.pressed ? "images/button_pressed.png" : "images/button_normal.png"
                width: 80; height: 24
                border.left: 3; border.top: 3
                border.right: 3; border.bottom: 3
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: enabled ? 1 : 0.3
                    source:"images/spinbox_down.png"
                }
            }
        }
    }

    property Component label: Component {
        Text {
            id:t
            color: styling.textColor
            text: model && currentIndex >= 0 ? model.get(currentIndex).text : ""
            opacity: enabled ? 1 : 0.5
        }
    }

    // Popout styling

    property Component popupFrame: Component {
        Item {
            Behavior on opacity { NumberAnimation { easing.type: Easing.OutQuad; duration: 250 } }

            anchors.leftMargin: 6
            anchors.topMargin: 6
            anchors.rightMargin: 7
            anchors.bottomMargin: 6

            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.margins: 1
                color: styling.backgroundColor
                radius: 5
            }
            BorderImage {
                anchors.fill: parent
                id: backgroundimage
                smooth: true
                source: "images/button_normal.png"
                width: 80; height: 24
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
            }
        }
    }

    property Component listItem: Component {
        Rectangle {
            width: styledItem.width
            height: Math.max(itemText.height, 28)
            color: highlighted ? "#556699" : "transparent"
            radius: 2
            border.width: 1
            border.color: Qt.darker(color)
            clip: true
            Text {
                id: itemText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 6

                font.bold: index == currentIndex
                color: highlighted ? "white" : styling.textColor
                anchors.margins: 10
                text: model ? model.get(index).text : ""  // list properties can't be automatically be added to the scope, so use get()
            }
        }
    }
}
