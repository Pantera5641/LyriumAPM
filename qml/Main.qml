import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 900
    height: 600
    color: "transparent"
    title: "LyriumAPM"
    flags: Qt.FramelessWindowHint | Qt.Window

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#17171B"
    }

    TittleBar {}
}