import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0

ColumnLayout {
    property string topText: ""
    property string fieldText: ""
    property var comboBoxModel: null
    property string modelId: ""

    property var com

    spacing: 8
    Layout.fillWidth: true
    Text {
        text: topText
        color: Colors.main
        font.pixelSize: 13
        font.bold: true
    }

    RowLayout {
        spacing: 10
        Layout.fillWidth: true

        Rectangle {
            Layout.preferredWidth: 280
            Layout.preferredHeight: 45
            color: Colors.lighterSubstrate
            radius: 8
            border.color: Colors.main
            border.width: 2

            Text {
                id: currentField
                anchors.fill: parent
                anchors.margins: 1
                text: fieldText
                color: Colors.additional
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                leftPadding: 12
                elide: Text.ElideRight
            }
        }

        ComboBox {
            id: comboBox
            model: comboBoxModel
            textRole: "name"
            Layout.preferredWidth: 170
            Layout.preferredHeight: 45
            currentIndex: -1
            displayText: currentIndex === -1 ? "Изменить" : currentText

            background: Rectangle {
                color: Colors.substrate
                border.color: Colors.main
                border.width: 2
                radius: 8
            }

            contentItem: Text {
                leftPadding: 12
                rightPadding: 30
                text: parent.displayText
                color: parent.currentIndex === -1 ? Colors.main : Colors.additional
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            indicator: Canvas {
                x: parent.width - width - 12
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
                    context.fillStyle = Colors.main
                    context.fill()
                }
            }

            delegate: ItemDelegate {
                width: ListView.view.width
                highlighted: ListView.isCurrentItem
                contentItem: Text {
                    text: name
                    color: Colors.text
                    font.pixelSize: 14
                    leftPadding: 12
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    color: highlighted ? Colors.hover : Colors.substrate
                }
            }

            Component.onCompleted: {
                modelId = find(fieldText)
            }

            onActivated: {
                if (currentIndex !== -1) {
                    modelId = currentIndex
                    fieldText =  comboBoxModel.getName(currentIndex);
                    currentIndex = -1
                    comboBox.displayText = "Изменить";
                }
            }
        }
    }
}