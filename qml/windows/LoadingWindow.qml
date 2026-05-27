import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

ApplicationWindow {
    id: loadingWindow
    visible: true
    width: 900
    height: 600
    color: "transparent"
    title: "Загрузка..."
    flags: Qt.FramelessWindowHint | Qt.Window

    signal finished()

    Item {
        anchors.fill: parent

        Video {
            id: videoPlayer
            anchors.fill: parent
            source: "qrc:/resources/loading.mp4"
            fillMode: VideoOutput.PreserveAspectFit
            Component.onCompleted: videoPlayer.play()

            onPositionChanged: {
                if (position >= duration && duration > 0) {
                    loadingWindow.finished()
                }
            }
        }
    }
}