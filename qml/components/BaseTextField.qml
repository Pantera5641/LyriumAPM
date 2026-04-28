import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    font.pixelSize: 16
    property bool error: false

    color: error ? "#c60046" : "#d05ce3"
    placeholderTextColor: error ? "#c60046" : "#8a2be2"

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