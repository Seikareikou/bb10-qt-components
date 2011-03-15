import QtQuick 1.1

QtObject {
    property int minimumWidth: 32
    property int minimumHeight: 32

    property Component background: Component {
        Item {
            width: styledItem.implicitWidth; height: styledItem.implicitHeight
            opacity: enabled ? 1 : 0.7
            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.margins: 1
                radius: 5
                color: styling.backgroundColor
            }
            BorderImage {
                anchors.fill: parent
                source: "images/lineedit_normal.png"
                smooth: true
                border.left: 6; border.top: 3
                border.right: 6; border.bottom: 3
            }
        }
    }

    property Component checkmark: Component {
        Image {
            source: "images/checkbox_check.png"
            opacity: (!enabled && checked) || pressed == true ? 0.5 : (!checked ? 0 : 1)
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        }
    }
}
