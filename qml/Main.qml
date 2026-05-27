import QtQuick 2.15
import QtQuick.Controls 2.15
import styles 1.0
import "windows"

ApplicationWindow {
    id: window
    visible: false
    width: 1200
    height: 900
    color: "transparent"
    title: "LyriumAPM"
    flags: Qt.FramelessWindowHint | Qt.Window

    property var loadingWindow: null
    Component.onCompleted: {
        if(!loadingWindow)
        {
            let component = Qt.createComponent("windows/LoadingWindow.qml")
            loadingWindow = component.createObject()
        }
        loadingWindow.show()
        loadingWindow.raise()
        loadingWindow.requestActivate()

        loadingWindow.finished.connect(() => {
            window.visible = true
            loadingWindow.destroy()
        })
    }

    Rectangle {
        color: Colors.background
        anchors.fill: parent
        radius: 8
        border.width: 1
        border.color: "#434343"
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