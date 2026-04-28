import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

ColumnLayout {
    anchors.fill: parent
    spacing: 0

    Item {
        id: titleBar
        Layout.fillWidth: true
        Layout.preferredHeight: 55

        MouseArea {
            anchors.fill: titleBar
            onPressed: window.startSystemMove()
        }

        Row {
            anchors.left: titleBar.left
            anchors.verticalCenter: titleBar.verticalCenter
            spacing: 25
            anchors.leftMargin: 10
            anchors.topMargin: 10

            Image {
                height: 35
                width: 35
                source: "qrc:/resources/logo.png"
                smooth: true
                mipmap: true
            }

            TabBar {
                id: tabBar
                currentIndex: stack.currentIndex
                spacing: parent.spacing
                background: Item {}

                PageTabButton { text: "Запись" }
                PageTabButton { text: "База Данных" }
                PageTabButton { text: "Статистика"}

                onCurrentIndexChanged: stack.currentIndex = currentIndex
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
                imgSource: "qrc:/resources/icon_dash.png"
                onClicked: window.showMinimized()
            }

            ImageButton {
                height: titleBar.height
                width: titleBar.height

                imgHeight: 15
                imgWidth: 15
                imgSource: "qrc:/resources/icon_cross.png"
                hoverColor: '#ff0000'
                onClicked: Qt.quit()
            }
        }

        Rectangle{
            height: 2
            width: parent.width
            color: '#9000ff'
            anchors.bottom: parent.bottom
        }
    }

    StackLayout {
        id: stack
        currentIndex: tabBar.currentIndex
        Layout.fillWidth: true
        Layout.fillHeight: true

        RecordPage{}
        DataBasePage{}
        GraphicsPage{}
    }
}