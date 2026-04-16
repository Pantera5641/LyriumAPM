import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Item {
    MediaPlayer {
        id: mediaPlayer
        source: "file:///C:/Users/Pantera5641/Desktop/Projects/QtCreator/LyriumAPM/resources/zaako.mp4"
    }

    VideoOutput {
        Layout.fillWidth: true
        Layout.fillHeight: true
        source: mediaPlayer
    }

    MouseArea {
        Layout.fillWidth: true
        Layout.fillHeight: true
        onPressed: mediaPlayer.play()
    }
}