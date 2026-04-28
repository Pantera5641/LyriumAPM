import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import "../components"

ApplicationWindow {
    id: easterWindow
    width: 960
    height: 595
    title: "Easter egg!!!"
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onPressed: easterWindow.startSystemMove()
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#17171B"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 55

            Image {
                height: 35
                width: 35
                source: "qrc:/resources/logo.png"
                smooth: true
                mipmap: true
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                anchors.topMargin: 10
            }

            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                ImageButton {
                    height: 55
                    width: 55

                    imgHeight: 15
                    imgWidth: 15
                    imgSource: "qrc:/resources/icon_dash.png"
                    onClicked: easterWindow.showMinimized()
                }

                ImageButton {
                    height: 55
                    width: 55

                    imgHeight: 15
                    imgWidth: 15
                    imgSource: "qrc:/resources/icon_cross.png"
                    hoverColor: '#ff0000'
                    onClicked: easterWindow.hide()
                }
            }

            Rectangle{
                height: 2
                width: parent.width
                color: '#9000ff'
                anchors.bottom: parent.bottom
            }
        }

        Item {
            width: 960
            height: 545

            Video {
                id: videoPlayer
                anchors.fill: parent
                source: "qrc:/resources/easter_egg.mp4"
                fillMode: VideoOutput.PreserveAspectFit
                loops: MediaPlayer.Infinite
                Component.onCompleted: videoPlayer.play()
            }
        }
    }

    property bool itVisible: false
    onVisibilityChanged: {
        itVisible = !itVisible;
        itVisible ? videoPlayer.play() : videoPlayer.pause()
    }
}