import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    MediaPlayer {
        id: mediaPlayer
        source: "../../resources/zaako.mp4"
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onPressed: mediaPlayer.play();
    }
}