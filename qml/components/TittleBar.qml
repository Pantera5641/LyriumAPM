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

        ImageButton {
            height: titleBar.height
            width: titleBar.height     

            imgHeight: 15
            imgWidth: 15
            imgSource: "../../resources/icon_dash.png"
            onClicked: window.showMinimized()
        }

        ImageButton {
            height: titleBar.height
            width: titleBar.height     

            imgHeight: 15
            imgWidth: 15
            imgSource: "../../resources/icon_maximize.png"
            onClicked: window.showMaximized()
        }

        ImageButton {
            height: titleBar.height
            width: titleBar.height     

            imgHeight: 15
            imgWidth: 15
            imgSource: "../../resources/icon_cross.png"
            hoverColor: '#FF0000'
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