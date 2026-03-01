import QtQuick
import QtQuick.Controls

Item {
    id: imageButton
    property alias imgSource: image.source
    property alias imgHeight: image.height
    property alias imgWidth: image.width
    property color hoverColor: '#2B2B2F'
    signal clicked

    Rectangle{
        anchors.fill: parent
        color: mouseArea.containsMouse ? hoverColor : 'transparent'
    }

    Image {
        id: image
        anchors.centerIn: parent
        source: ""
        smooth: true
        mipmap: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: imageButton.clicked()
    }
}