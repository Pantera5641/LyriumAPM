import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

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
        color: "#8a2be2"
        font.pixelSize: 13
        font.bold: true
    }

    RowLayout {
        spacing: 10
        Layout.fillWidth: true

        Rectangle {
            Layout.preferredWidth: 280
            Layout.preferredHeight: 45
            color: "#1a1a1a"
            radius: 8
            border.color: "#8a2be2"
            border.width: 2

            Text {
                id: currentField
                anchors.fill: parent
                anchors.margins: 1
                text: fieldText
                color: "#d05ce3"
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
                color: "#000000"
                border.color: "#8a2be2"
                border.width: 2
                radius: 8
            }

            contentItem: Text {
                leftPadding: 12
                rightPadding: 30
                text: parent.displayText
                color: parent.currentIndex === -1 ? "#8a2be2" : "#d05ce3"
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
                    context.fillStyle = "#8a2be2"
                    context.fill()
                }
            }

            delegate: ItemDelegate {
                width: ListView.view.width
                highlighted: ListView.isCurrentItem
                contentItem: Text {
                    text: name
                    color: "#ffffff"
                    font.pixelSize: 14
                    leftPadding: 12
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    color: highlighted ? "#3d0e69" : "#09020f"
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