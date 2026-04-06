import QtQuick
import QtQuick.Controls

ComboBox {
    id: baseComboBox
    background: Rectangle {
        color: "#000000"
        border.color: "#8a2be2"
        border.width: 2
        radius: 12
    }

    contentItem: Text {
        leftPadding: 15
        rightPadding: 40
        text: parent.displayText

        color: parent.currentIndex === 0 ? "#8a2be2" : "#d05ce3"

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
            context.fillStyle = "#8a2be2"
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