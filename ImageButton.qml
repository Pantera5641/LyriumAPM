import QtQuick
import QtQuick.Controls

Item {
    id: imageButton
    property alias imgSource: image.source
    signal clicked

    Image {
        id: image
        anchors.centerIn: parent
        anchors.fill: parent
        source: ""
        smooth: true
        mipmap: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: imageButton.clicked()
    }
}