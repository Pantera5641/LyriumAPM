import QtQuick
import QtQuick.Controls


Grid {
    id: titleBar
    height: 75
    width: parent.width

    MouseArea {
        anchors.fill: parent
        onPressed: window.startSystemMove()
    }

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 30
        anchors.leftMargin: 15
        anchors.topMargin: 15

        Image {
            height: 45
            width: 45
            source: "../../resources/logo.png"
            smooth: true
            mipmap: true
        }

        TabBar {
            spacing: parent.spacing
            //indicator: Item {} хз как пофиксить серую полоску

            PageTabButton { text: "Запись" }
            PageTabButton { text: "База Данных" }
            PageTabButton { text: "Графики"}
        }
    }

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 30
        anchors.rightMargin: 20

        ImageButton {
            height: 20
            width: 20
            imgSource: "../../resources/icon_dash.png"
            onClicked: window.showMinimized()
        }

        ImageButton {
            height: 20
            width: 20
            imgSource: "../../resources/icon_maximize.png"
            onClicked: window.showMaximized()
        }

        ImageButton {
            height: 20
            width: 20
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