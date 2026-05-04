import QtQuick 2.15
import QtQuick.Controls 2.15
import styles 1.0

TabButton{
    id: pageTabButton
    
    background: Rectangle{
        color: "transparent"
    }

    contentItem: TabText {
        text: pageTabButton.text
        color: pageTabButton.checked ? Colors.main : Colors.text
    }

    width: contentItem.implicitWidth + 10
    height: contentItem.implicitHeight + 10

    Rectangle{
        height: 3
        width: parent.width
        color: pageTabButton.checked ? Colors.main : 'transparent'
        anchors.bottom: parent.bottom
    }
}