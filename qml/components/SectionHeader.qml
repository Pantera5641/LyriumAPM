import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string text: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 30
    Layout.topMargin: 5
    color: "transparent"
    Text {
        text: parent.text
        color: "#8a2be2"
        font.bold: true
        font.pixelSize: 16
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: "#8a2be2"
        opacity: 0.5
    }
}