import QtQuick 2.15
import QtQuick.Controls 2.15
import styles 1.0

ComboBox {
    id: root
    currentIndex: -1
    displayText: currentIndex === -1 ? baseText : currentText

    property bool error: false
    property string baseText: currentText
    property real delegateFontMultiplier: 0.3

    onActivated: {
        if (currentIndex !== -1 && error) error = false
    }

    background: Rectangle {
        color: Colors.substrate
        border.color: error ? Colors.mainError : Colors.main
        border.width: 2
        radius: root.height * 0.25
    }

    contentItem: Text {
        leftPadding: root.width * 0.03
        rightPadding: root.width * 0.12
        text: parent.displayText
        color: parent.currentIndex === -1 ? (error ? Colors.additionalError : Colors.main) : Colors.additional
        font.pixelSize: root.height * 0.34
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Canvas {
        height: root.height * 0.2
        width: height * 1.5
        x: parent.width - width - (root.width * 0.03)
        y: parent.height / 2 - height / 2
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
        height: root.height
        highlighted: ListView.isCurrentItem
        contentItem: Text {
            text: name
            color: Colors.text
            font.pixelSize: root.height * root.delegateFontMultiplier
            leftPadding: root.width * 0.03
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: highlighted ? "#3d0e69" : "#09020f"
        }
    }
}