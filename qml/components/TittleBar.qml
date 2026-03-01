import QtQuick
import QtQuick.Controls


Grid {
    id: titleBar
    height: 55
    width: parent.width

    MouseArea {
        anchors.fill: parent
        onPressed: window.startSystemMove()
    }

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 25
        anchors.leftMargin: 10
        anchors.topMargin: 10

        Image {
            height: 35
            width: 35
            source: "../../resources/logo.png"
            smooth: true
            mipmap: true
        }

        TabBar {
            spacing: parent.spacing
            background: Item {}

            PageTabButton { text: "Запись" }
            PageTabButton { text: "База Данных" }
            PageTabButton { text: "Графики"}
        }
    }

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 15
        anchors.rightMargin: 20

        ImageButton {
            height: 15
            width: 15
            imgSource: "../../resources/icon_dash.png"
            onClicked: window.showMinimized()
        }

        ImageButton {
            height: 15
            width: 15
            imgSource: "../../resources/icon_maximize.png"
            onClicked: window.showMaximized()
        }

        ImageButton {
            height: 15
            width: 15
            imgSource: "../../resources/icon_cross.png"
            onClicked: Qt.quit()
        }
    }

    Rectangle{
        height: 2
        width: parent.width
        color: '#9000FF'
        anchors.bottom: parent.bottom
    }
}