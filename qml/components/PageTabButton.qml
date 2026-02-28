import QtQuick
import QtQuick.Controls

TabButton{
    id: pageTabButton
    
    background: Rectangle{
        color: "transparent"
    }

    contentItem: TabText {
        text: pageTabButton.text
        anchors.centerIn: parent
        color: pageTabButton.pressed ? '#9000FF' : '#FFFFFF'
    }

    width: contentItem.implicitWidth + 10
    height: contentItem.implicitHeight + 10

    Rectangle{
        height: 5
        width: parent.width
        color: pageTabButton.pressed ? '#9000FF' : 'transparent'
        anchors.bottom: parent.bottom
    }
}