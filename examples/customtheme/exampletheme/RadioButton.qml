import QtQuick 1.0
import "../../../components" as Components

Components.RadioButton{
    background: Image{
        source: "images/radiobutton_normal.png"
    }

    checkmark:Image{
        anchors.centerIn:parent
        source: "images/radiobutton_check.png"
        Behavior on opacity { NumberAnimation{easing.type:Easing.OutCubic}}
    }
}
