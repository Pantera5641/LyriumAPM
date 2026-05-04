import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0

ColumnLayout {
    property string label: ""
    property alias text: textField.text
    property alias readOnly: textField.readOnly

    property var fieldHeight: 45

    spacing: 5
    Layout.fillWidth: true
    Text {
        text: label
        color: Colors.main
        font.pixelSize: 13
        font.bold: true
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: fieldHeight
        color: textField.readOnly ? "#1a1a1a" : Colors.substrate
        radius: 8
        border.color: textField.focus ? Colors.additional : Colors.main
        border.width: 2

        TextField {
            id: textField
            anchors.fill: parent
            anchors.margins: 1
            color: Colors.additional
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            leftPadding: 12
            rightPadding: 12
            background: Rectangle { color: "transparent" }
        }
    }
}