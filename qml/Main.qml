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

    Shortcut {
        sequence: "Ctrl+Shift+E"
        property var easterWindow: null

        onActivated: {
            if(!easterWindow)
            {
                let component = Qt.createComponent("windows/EasterWindow.qml")
                easterWindow = component.createObject()
            }
            easterWindow.show()
            easterWindow.raise()
            easterWindow.requestActivate()
        }
    }
}