import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0
import "../components"

Item {
    id: dataBasePage
    Layout.fillWidth: true
    Layout.fillHeight: true

    Column {
        width: parent.width
        height: parent.height
        spacing: parent.width * 0.025
        padding: parent.height * 0.04

        Row {
            width: parent.width
            height: parent.height * 0.058
            spacing: parent.width * 0.025

            Row {
                spacing: parent.width * 0.02
                Text {
                    text: "Сортировка"
                    color: Colors.main
                    font.bold: true
                    font.pixelSize: dataBasePage.height * 0.02
                    anchors.verticalCenter: parent.verticalCenter
                }
                BaseComboBox {
                    id: sortBox
                    model: sortTagModel
                    currentIndex: 0
                    textRole: "name"
                    width: dataBasePage.width * 0.3
                    height: dataBasePage.height * 0.058
                    onActivated: {
                        databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                    }
                }
            }

            Row {
                spacing: parent.width * 0.02
                Text {
                    text: "Поиск"
                    color: Colors.main
                    font.bold: true
                    font.pixelSize: dataBasePage.height * 0.02
                    anchors.verticalCenter: parent.verticalCenter
                }
                BaseTextField {
                    id: searchField
                    placeholderText: "Начните печатать..."
                    width: dataBasePage.width * 0.3
                    height: dataBasePage.height * 0.058
                    onTextChanged: {
                        databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                    }
                }
            }

            Rectangle {
                width: dataBasePage.width * 0.05
                height: dataBasePage.height * 0.05
                color: "transparent"
                radius: dataBasePage.height * 0.01
                border.color: Colors.main
                border.width: Math.max(1, dataBasePage.height * 0.0025)
                Image {
                    anchors.centerIn: parent
                    width: dataBasePage.height * 0.04
                    height: dataBasePage.height * 0.04
                    source: "qrc:/resources/report_icon.png"
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.8
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: parent.border.color = Colors.additional
                    onExited: parent.border.color = Colors.main
                    onClicked: {
                        reportsBuilder.createFullReport()
                        reportsBuilder.openReportsFolder()
                    }
                }
            }
        }

        Rectangle {
            width: dataBasePage.width * 0.96
            height: dataBasePage.height * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.main
            radius: dataBasePage.height * 0.02

            Rectangle {
                anchors.centerIn: parent
                width: dataBasePage.width * 0.957
                height: dataBasePage.height * 0.795
                color: Colors.substrate
                radius: dataBasePage.height * 0.02
                clip: true

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: dataBasePage.height * 0.05

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: Math.max(1, dataBasePage.height * 0.002)
                            color: Colors.main
                        }

                        Row {
                            anchors.fill: parent
                            Rectangle { width: parent.width * 0.06; height: parent.height; color: "transparent"; Text { text: "ID"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.21; height: parent.height; color: "transparent"; Text { text: "Заказчик"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.12; height: parent.height; color: "transparent"; Text { text: "Дата"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.17; height: parent.height; color: "transparent"; Text { text: "Марка"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.12; height: parent.height; color: "transparent"; Text { text: "Мастер"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.12; height: parent.height; color: "transparent"; Text { text: "Цена"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                            Rectangle { width: parent.width * 0.20; height: parent.height; color: "transparent"; Text { text: "Статус"; color: Colors.text; font.bold: true; font.pixelSize: dataBasePage.height * 0.02; anchors.centerIn: parent } }
                        }
                    }

                    ScrollView {
                        id: scrollView
                        width: parent.width
                        height: parent.height - (dataBasePage.height * 0.05)
                        background: Item {}
                        clip: true
                        contentWidth: width
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                        Column {
                            id: rootColumn
                            width: scrollView.width
                            spacing: 0
                            clip: true
                            property var dataList: databaseModel

                            Repeater {
                                id: repeater
                                model: parent.dataList
                                delegate: Item {
                                    width: rootColumn.width
                                    height: dataBasePage.height * 0.05

                                    Rectangle {
                                        anchors.fill: parent
                                        color: (index % 2 === 0) ? Colors.lighterSubstrate : Colors.substrate
                                    }

                                    Row {
                                        anchors.fill: parent
                                        spacing: 0

                                        TableTextHolder {
                                            width: parent.width * 0.06
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                id: idText
                                                text: idRole
                                                color: idMouseArea.containsMouse ? Colors.main : Colors.additional
                                                font.pixelSize: dataBasePage.height * 0.018
                                                font.underline: idMouseArea.containsMouse
                                                anchors.centerIn: parent
                                            }
                                            MouseArea {
                                                id: idMouseArea
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onClicked: { dataBasePage.openEditWindow(idRole) }
                                            }
                                        }

                                        TableTextHolder { width: parent.width * 0.21; textFiller: clientShortName }
                                        TableTextHolder { width: parent.width * 0.12; textFiller: date }
                                        TableTextHolder { width: parent.width * 0.17; textFiller: carBrand }
                                        TableTextHolder { width: parent.width * 0.12; textFiller: masterShortName }
                                        TableTextHolder { width: parent.width * 0.12; textFiller: price }

                                        Rectangle {
                                            width: parent.width * 0.20
                                            height: parent.height
                                            color: "transparent"
                                            clip: true

                                            BaseComboBox {
                                                id: statusBox
                                                model: statusModel
                                                textRole: "name"
                                                delegateFontMultiplier: 0.45
                                                anchors.left: parent.left
                                                anchors.leftMargin: parent.width * 0.33
                                                anchors.right: parent.right
                                                anchors.rightMargin: parent.width * 0.05
                                                anchors.verticalCenter: parent.verticalCenter
                                                implicitHeight: dataBasePage.height * 0.045
                                                Component.onCompleted: { currentIndex = find(status) }
                                                onActivated: {
                                                    databaseModel.setStatus(idRole, statusModel.getTag(statusBox.currentIndex))
                                                    databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                                                }
                                                background: Rectangle { color: "transparent" }
                                                contentItem: Text {
                                                    leftPadding: 5
                                                    rightPadding: 5
                                                    text: parent.displayText
                                                    color: Colors.additional
                                                    font.pixelSize: dataBasePage.height * 0.018
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignVCenter
                                                    elide: Text.ElideNone
                                                }
                                                indicator: Image {
                                                    width: parent.height * 0.4
                                                    height: parent.height * 0.4
                                                    source: "qrc:/resources/down-arrow.png"
                                                    fillMode: Image.PreserveAspectFit
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: parent.width * 0.08
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    smooth: true
                                                    mipmap:true
                                                }

                                            }
                                        }
                                    }

                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        width: parent.width
                                        height: Math.max(1, dataBasePage.height * 0.0015)
                                        color: "#333333"
                                        z: 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function openEditWindow(recordId) {
        const component = Qt.createComponent("EditWindow.qml")
        if (component.status === Component.Ready) {
            const editWindow = component.createObject(dataBasePage, {"recordId": recordId})
            editWindow.show()
        }
    }
}