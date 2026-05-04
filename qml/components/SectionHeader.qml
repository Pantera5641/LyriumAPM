import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0

Rectangle {
    property string text: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 30
    Layout.topMargin: 5
    color: "transparent"
    Text {
        text: parent.text
        color: Colors.main
        font.bold: true
        font.pixelSize: 16
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Colors.main
        opacity: 0.5
    }
}