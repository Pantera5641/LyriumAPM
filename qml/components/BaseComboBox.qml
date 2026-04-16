import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox {
    id: baseComboBox
    property bool error: false

    onActivated: {
        if (currentIndex !== 0 && error)
            error = false;
    }

    background: Rectangle {
        color: "#000000"
        border.color: error ? "#ff0000" : "#8a2be2"
        border.width: 2
        radius: 12
    }

    contentItem: Text {
        leftPadding: 15
        rightPadding: 40
        text: parent.displayText

        color: parent.currentIndex === 0
            ? (error ? "#ff0000" : "#8a2be2")
            : (error ? "#c60046" : "#d05ce3")

        font.pixelSize: 16

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
            context.fillStyle = error ? "#ff0000" : "#8a2be2"
            context.fill()
        }
    }

    delegate: ItemDelegate {
        width: parent.width
        highlighted: ListView.isCurrentItem

        contentItem: Text {
            text: name
            color: "#ffffff"
            font.pixelSize: 16

            leftPadding: 15
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: highlighted ? "#3d0e69" : "#09020f"
        }
    }
}