import QtQuick
import QtQuick.Controls

Item {
    id: recordPage
    anchors.fill: parent

    Substrate{
        anchors.fill: text
    }

    Text {
        id: text
        text: "RecordPage.qml"
        anchors.centerIn: parent
        font.pixelSize: 64
        font.weight: Font.DemiBold
        color: "#FFFFFF"
    }
}