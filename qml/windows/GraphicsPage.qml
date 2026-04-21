import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Item {
    Rectangle{
        anchors.fill: parent
        color: '#101010'
    }

    Video {
        id: videoPlayer
        anchors.fill: parent
        source: "qrc:/resources/easter_egg.mp4"
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.PreserveAspectFit

        onVisibleChanged: {
            visible ? videoPlayer.play() : videoPlayer.pause()
        }
    }
}