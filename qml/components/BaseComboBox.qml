import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0

ComboBox {
    property bool error: false
    property string baseText: currentText

    Layout.fillWidth: true
    Layout.fillHeight: true
    implicitWidth: 0
    implicitHeight: 0
    currentIndex: -1
    displayText: currentIndex === -1 ? baseText : currentText

    onActivated: {
        if (currentIndex !== -1 && error)
            error = false;
    }

    background: Rectangle {
        color: Colors.substrate
        border.color: error ? Colors.mainError : Colors.main
        border.width: 2
        radius: 12
    }

    contentItem: Text {
        leftPadding: 15
        rightPadding: 40
        text: parent.displayText

        color: parent.currentIndex === -1
            ? (error ? Colors.additionalError : Colors.main) : Colors.additional

        font.pixelSize: parent.height * 0.35

        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Canvas {
        x: parent.width - width - 15
        y: parent.height / 2 - height / 2
        width: 12
        height: 8
        contextType: "2d"

        onPaint: {
            context.reset()
            context.moveTo(0, 0)
            context.lineTo(width, 0)
            context.lineTo(width / 2, height)
            context.closePath()
            context.fillStyle = error ? Colors.mainError : Colors.main
            context.fill()
        }
    }

    delegate: ItemDelegate {
        width: parent.width
        highlighted: ListView.isCurrentItem

        contentItem: Text {
            text: name
            color: Colors.text
            font.pixelSize: 16

            leftPadding: 15
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: highlighted ? "#3d0e69" : "#09020f"
        }
    }
}