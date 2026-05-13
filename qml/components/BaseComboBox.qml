import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0

ComboBox {
    id: baseComboBox

    property bool error: false
    property string baseText: currentText
    property real delegateFontMultiplier: 0.35

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
        leftPadding: baseComboBox.width * 0.03
        rightPadding: baseComboBox.width * 0.12
        text: parent.displayText

        color: parent.currentIndex === -1
            ? (error ? Colors.additionalError : Colors.main) : Colors.additional

        font.pixelSize: parent.height * 0.35

        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Image {
        width: parent.height * 0.4
        height: parent.height * 0.4
        source: "qrc:/resources/down-arrow.png"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.rightMargin: baseComboBox.width * 0.035
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        mipmap:true
    }

    delegate: ItemDelegate {
        width: parent.width
        height: baseComboBox.height
        highlighted: ListView.isCurrentItem

        contentItem: Text {
            text: name
            color: Colors.text
            font.pixelSize: baseComboBox.height * baseComboBox.delegateFontMultiplier
            leftPadding: baseComboBox.width * 0.03
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: highlighted ? Colors.hover : Colors.substrate
        }
    }
}