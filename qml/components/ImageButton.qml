import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import styles 1.0

Item {
    id: imageButton
    property alias imgSource: image.source
    property alias imgHeight: image.height
    property alias imgWidth: image.width
    property color imgBaseColor: Colors.invertedBackground
    property color imgHoverColor: Colors.invertedBackground
    property color hoverColor: Colors.backgroundShade
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

    ColorOverlay {
        anchors.fill: image
        source: image
        color: mouseArea.containsMouse ? imgHoverColor : imgBaseColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: imageButton.clicked()
    }
}