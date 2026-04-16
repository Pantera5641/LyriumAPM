import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 100
    height: parent.height
    color: "transparent"
    property string textFiller: ""

    Text {
        text: textFiller
        color: "#d05ce3"
        font.pixelSize: 14
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        leftPadding: 5
        rightPadding: 5
    }
}