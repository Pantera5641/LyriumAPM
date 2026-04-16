import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: imageButton
    property alias imgSource: image.source
    property alias imgHeight: image.height
    property alias imgWidth: image.width
    property color hoverColor: '#2b2b2f'
    signal clicked

    Rectangle{
        anchors.fill: parent
        color: mouseArea.containsMouse ? hoverColor : 'transparent'
    }

    Image {
        id: image
        anchors.centerIn: parent
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