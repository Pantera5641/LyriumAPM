import QtQuick 2.15
import QtQuick.Controls 2.15
import styles 1.0

TextField {
    font.pixelSize: 16
    property bool error: false

    color: error ? Colors.additionalError : Colors.additional
    placeholderTextColor: error ? Colors.additionalError : Colors.main

    leftPadding: 15
    rightPadding: 15
    verticalAlignment: Text.AlignVCenter

    background: Rectangle {
        anchors.fill: parent
        color: Colors.substrate
        border.width: 2
        radius: 12
        border.color: error
            ? (parent.focus ? Colors.additionalError : Colors.mainError)
            : (parent.focus ? Colors.additional : Colors.main)

        Behavior on border.color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}