import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

Item {
    MediaPlayer {
        id: mediaPlayer
        source: "qrc:/resources/zaako.mp4"
    }

    VideoOutput {
        anchors.fill: parent
        source: mediaPlayer
    }

    MouseArea {
        anchors.fill: parent
        onPressed: mediaPlayer.play()
    }
}