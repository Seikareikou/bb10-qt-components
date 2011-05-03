import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    id: template

    implicitWidth: style.minimumWidth
    implicitHeight: style.minimumHeight

    property RadioButtonStyle style: RadioButtonStyle {
        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth

        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight

        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor
    }

    property RadioButtonStyle themeStyle: RadioButtonStyle {}
}
