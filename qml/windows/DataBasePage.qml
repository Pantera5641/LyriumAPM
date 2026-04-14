import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: dataBasePage
    anchors.fill: parent

    // Темный фон страницы
    Rectangle {
        anchors.fill: parent
        color: "#121212"
        z: -1
    }

    Column {
        width: parent.width
        spacing: 20
        padding: 20


        // === ВЕРХНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ ===
        Row {
            width: parent.width
            padding: 30
            spacing: 55

            // Блок Сортировки
            Row {
                spacing: 15

                Text {
                    text: "Сортировка"
                    color: "#8a2be2"
                    font.bold: true
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }

                BaseComboBox {
                    model: sortTagModel
                    textRole: "name"
                    width: 250
                    height: 45
                }
            }

            // Блок Поиска
            Row {
                spacing: 15

                Text {
                    text: "Поиск"
                    color: "#8a2be2"
                    font.bold: true
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }

                BaseTextField {
                    id: searchField
                    placeholderText: "Начните печатать..."
                    width: 310
                    height: 45
                }
            }
        }

        // === ТАБЛИЦА ===
        // Контейнер для рамки
        Rectangle {
            width: 804
            height: 454
            anchors.horizontalCenter: parent.horizontalCenter

            color: "#8a2be2"
            radius: 17

            // Внутренняя таблица
            Rectangle {
                anchors.centerIn: parent
                width: 800
                height: 450

                color: "#000000"
                radius: 15
                clip: true

                Column {
                    anchors.fill: parent

                    // --- ШАПКА ТАБЛИЦЫ ---
                    Item {
                        width: parent.width
                        height: 40

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 2
                            color: "#8a2be2"
                            z: 0
                        }

                        Row {
                            anchors.fill: parent
                            z: 10

                            // ID
                            Rectangle {
                                width: 50
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "ID"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Заказчик
                            Rectangle {
                                width: 160
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Заказчик"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Дата
                            Rectangle {
                                width: 100
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Дата"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Марка
                            Rectangle {
                                width: 140
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Марка"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Мастер
                            Rectangle {
                                width: 100
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Мастер"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Цена
                            Rectangle {
                                width: 100
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Цена"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }

                            // Статус
                            Rectangle {
                                width: 150
                                height: parent.height
                                color: "transparent"
                                Text {
                                    text: "Статус"
                                    color: "#FFFFFF"
                                    font.bold: true
                                    font.pixelSize: 14
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }

                    // --- СПИСОК ДАННЫХ ---
                    ScrollView {
                        id: scrollView
                        width: parent.width
                        height: parent.height - 40
                        clip: true
                        contentWidth: width

                        Column {
                            id: rootColumn
                            width: scrollView.width
                            spacing: 0

                            property var dataList: databaseModel

                            Repeater {
                                model: parent.dataList

                                delegate: Item {
                                    width: rootColumn.width
                                    height: 40

                                    // Фон строки
                                    Rectangle {
                                        anchors.fill: parent
                                        color: (index % 2 === 0) ? "#050505" : "#000000"
                                    }

                                    Row {
                                        anchors.fill: parent
                                        spacing: 0

                                        // ID
                                        Rectangle {
                                            width: 50
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: idRole
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.centerIn: parent
                                            }
                                        }

                                        // Заказчик
                                        Rectangle {
                                            width: 160
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: username
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                elide: Text.ElideRight
                                                leftPadding: 5
                                                rightPadding: 5
                                            }
                                        }

                                        // Дата
                                        Rectangle {
                                            width: 100
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: date
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.centerIn: parent
                                            }
                                        }

                                        // Марка
                                        Rectangle {
                                            width: 140
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: carBrand
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                elide: Text.ElideRight
                                                leftPadding: 5
                                                rightPadding: 5
                                            }
                                        }

                                        // Мастер
                                        Rectangle {
                                            width: 100
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: master
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                elide: Text.ElideRight
                                                leftPadding: 5
                                                rightPadding: 5
                                            }
                                        }

                                        // Цена
                                        Rectangle {
                                            width: 100
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                text: price
                                                color: "#d05ce3"
                                                font.pixelSize: 14
                                                anchors.centerIn: parent
                                            }
                                        }

                                        // Статус
                                        Rectangle {
                                            width: 150
                                            height: parent.height
                                            color: "transparent"

                                            ComboBox {
                                                id: status
                                                model: [" ", "В работе", "Готов", "Отменен"]
                                                width: 130
                                                height: 35
                                                anchors.centerIn: parent

                                                background: Rectangle {
                                                    color: "transparent"
                                                }

                                                contentItem: Text {
                                                    leftPadding: 10
                                                    rightPadding: 25
                                                    text: parent.displayText
                                                    color: parent.currentIndex === 0 ? "#8a2be2" : "#d05ce3"
                                                    font.pixelSize: 14
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    elide: Text.ElideRight
                                                }

                                                indicator: Canvas {
                                                    x: parent.width - width - 8
                                                    y: parent.height / 2 - height / 2
                                                    width: 10
                                                    height: 6
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
                                            }
                                        }
                                    }

                                    // Разделительная линия
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
}