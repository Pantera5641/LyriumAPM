import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    property string label: ""
    property alias text: textField.text
    property alias readOnly: textField.readOnly

    property var fieldHeight: 45

    spacing: 5
    Layout.fillWidth: true
    Text {
        text: label
        color: "#8a2be2"
        font.pixelSize: 13
        font.bold: true
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: fieldHeight
        color: textField.readOnly ? "#1a1a1a" : "#000000"
        radius: 8
        border.color: textField.focus ? "#d05ce3" : "#8a2be2"
        border.width: 2

        TextField {
            id: textField
            anchors.fill: parent
            anchors.margins: 1
            color: "#d05ce3"
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            leftPadding: 12
            rightPadding: 12
            background: Rectangle { color: "transparent" }
        }
    }
}