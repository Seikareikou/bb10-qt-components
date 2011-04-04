import QtQuick 1.1
import "../../../components"

Item {
    property alias title: pageTitle.text
    property alias backEnabled: backButton.visible

    Text {
        id: pageTitle
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 22
        font.family: "Nokia Sans"
        style: Text.Sunken
        styleColor: "#aaaaaa"
        color: "#cccccc"
        z: 1
    }

    Button {
        id: backButton
        text: "back"
        width: 60
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        onClicked: back();
    }
}
