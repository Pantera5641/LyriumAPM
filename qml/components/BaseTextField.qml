import QtQuick
import QtQuick.Controls

TextField {
    font.pixelSize: 16
    property bool error: false

    color: error ? "#c60046" : "#d05ce3"
    placeholderTextColor: error ? "#ff0000" : "#8a2be2"

    leftPadding: 15
    rightPadding: 15
    verticalAlignment: Text.AlignVCenter

    background: Rectangle {
        anchors.fill: parent
        color: "#000000"
        border.width: 2
        radius: 12
        border.color: error
            ? (parent.focus ? "#c60046" : "#ff0000")
            : (parent.focus ? "#d05ce3" : "#8a2be2")
        Behavior on border.color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}