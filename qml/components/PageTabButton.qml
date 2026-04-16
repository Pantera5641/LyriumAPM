import QtQuick 2.15
import QtQuick.Controls 2.15

TabButton{
    id: pageTabButton
    
    background: Rectangle{
        color: "transparent"
    }

    contentItem: TabText {
        text: pageTabButton.text
        color: pageTabButton.checked ? '#9000FF' : '#FFFFFF'
    }

    width: contentItem.implicitWidth + 10
    height: contentItem.implicitHeight + 10

    Rectangle{
        height: 3
        width: parent.width
        color: pageTabButton.checked ? '#9000FF' : 'transparent'
        anchors.bottom: parent.bottom
    }
}