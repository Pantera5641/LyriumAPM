import QtQuick 2.15
import QtQuick.Controls 2.15
import "windows"

ApplicationWindow {
    id: window
    visible: true
    width: 900
    height: 700
    color: "transparent"
    title: "LyriumAPM"
    flags: Qt.FramelessWindowHint | Qt.Window

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#17171B"
    }

    TitleBar {}
}