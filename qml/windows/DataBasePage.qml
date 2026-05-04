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
        spacing: 20
        padding: 20

        Row {
            width: parent.width
            padding: 30
            spacing: 30
            Row {
                spacing: 15
                Text {
                    text: "Сортировка"
                    color: Colors.main
                    font.bold: true
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }

                BaseComboBox {
                    id: sortBox
                    model: sortTagModel
                    currentIndex: 0
                    textRole: "name"
                    width: 230
                    height: 45
                    onActivated: {
                        databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                    }
                }
            }
            Row {
                spacing: 15
                Text {
                    text: "Поиск"
                    color: Colors.main
                    font.bold: true
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }
                BaseTextField {
                    id: searchField
                    placeholderText: "Начните печатать..."
                    width: 285
                    height: 45
                    onTextChanged: {
                        databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                    }
                }
            }

            Rectangle {
                width: 50
                height: 50
                color: "transparent"
                radius: 8
                border.color: Colors.main
                border.width: 2

                Image {
                    anchors.centerIn: parent
                    width: 30
                    height: 30
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
            width: 805
            height: 455
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.main
            radius: 17
            Rectangle {
                anchors.centerIn: parent
                width: 800
                height: 450
                color: Colors.substrate
                radius: 15
                clip: true
                Column {
                    anchors.fill: parent
                    Item {
                        width: parent.width
                        height: 40
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 2
                            color: Colors.main
                            z: 0
                        }
                        Row {
                            anchors.fill: parent
                            z: 10
                            Rectangle { width: 50; height: parent.height; color: "transparent"; Text { text: "ID"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 160; height: parent.height; color: "transparent"; Text { text: "Заказчик"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 100; height: parent.height; color: "transparent"; Text { text: "Дата"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 140; height: parent.height; color: "transparent"; Text { text: "Марка"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 100; height: parent.height; color: "transparent"; Text { text: "Мастер"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 100; height: parent.height; color: "transparent"; Text { text: "Цена"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                            Rectangle { width: 150; height: parent.height; color: "transparent"; Text { text: "Статус"; color: Colors.text; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent } }
                        }
                    }
                    ScrollView {
                        id: scrollView
                        width: parent.width
                        height: parent.height - 50
                        clip: true
                        contentWidth: width
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                        Column {
                            id: rootColumn
                            width: scrollView.width
                            spacing: 0
                            property var dataList: databaseModel

                            Repeater {
                                id: repeater
                                model: parent.dataList
                                delegate: Item {
                                    width: rootColumn.width
                                    height: 40
                                    Rectangle {
                                        anchors.fill: parent
                                        color: (index % 2 === 0) ? "#050505" : Colors.substrate
                                    }

                                    Row {
                                        anchors.fill: parent
                                        spacing: 0

                                        TableTextHolder {
                                            width: 50
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                id: idText
                                                text: idRole
                                                color: idMouseArea.containsMouse ? Colors.main : Colors.additional
                                                font.pixelSize: 14
                                                font.underline: idMouseArea.containsMouse
                                                anchors.centerIn: parent
                                            }
                                            MouseArea {
                                                id: idMouseArea
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true

                                                onClicked: {
                                                    dataBasePage.openEditWindow(idRole)
                                                }
                                            }
                                        }
                                        TableTextHolder { width: 160; textFiller: clientShortName }
                                        TableTextHolder { width: 100; textFiller: date }
                                        TableTextHolder { width: 140; textFiller: carBrand }
                                        TableTextHolder { width: 100; textFiller: masterShortName }
                                        TableTextHolder { width: 100; textFiller: price }

                                        Rectangle {
                                            width: 150;
                                            height: parent.height;
                                            color: "transparent"

                                            BaseComboBox {
                                                id: statusBox
                                                model: statusModel
                                                textRole: "name"
                                                width: 130;
                                                height: 35
                                                anchors.centerIn: parent

                                                Component.onCompleted: {
                                                    currentIndex = find(status)
                                                }

                                                onActivated: {
                                                    databaseModel.setStatus(idRole, statusModel.getTag(statusBox.currentIndex))
                                                    databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), searchField.text)
                                                }

                                                background: Rectangle { color: "transparent" }

                                                contentItem: Text {
                                                    leftPadding: 10;
                                                    rightPadding: 5
                                                    text: parent.displayText
                                                    color: Colors.additional
                                                    font.pixelSize: 14
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    elide: Text.ElideRight
                                                }
                                                indicator: Canvas {
                                                    x: parent.width - width - 8
                                                    y: parent.height / 2 - height / 2
                                                    width: 10; height: 6
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
                                            }
                                        }
                                    }
                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        width: parent.width
                                        height: 1
                                        color: "#333333"
                                        z: 1
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
        const component = Qt.createComponent("EditWindow.qml");
        if (component.status === Component.Ready) {
            const editWindow = component.createObject(dataBasePage, {"recordId": recordId});
            editWindow.show()
        }
    }
}
