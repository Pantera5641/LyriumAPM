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
            padding: 20
            spacing: 50

            // Блок Сортировки
            Row {
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "Сортировка"
                    color: "#8a2be2"
                    font.bold: true
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                }

                BaseComboBox {
                    model: [
                        { name: "None", teg:"non" },
                        { name: "Дата" },
                        { name: "Цена" },
                        { name: "Имя заказчика" }
                    ]
                    textRole: "name"
                    width: 300
                    height: 45
                }

            }


            // Блок Поиска
            Row {
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "Поиск"
                    color: "#ffffff"
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                }

                TextField {
                    id: searchField
                    placeholderText: "Начните печатать..."
                    width: 250
                    height: 35

                    color: "#d05ce3"
                    placeholderTextColor: "#555555"
                    leftPadding: 10
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        color: "#000000"
                        border.color: "#8a2be2"
                        border.width: 2
                        radius: 8
                    }
                }
            }
        }

        // === ТАБЛИЦА ===
        // Контейнер для рамки (фиолетовый фон)
        Rectangle {
            width: 804
            height: 454
            anchors.horizontalCenter: parent.horizontalCenter

            color: "#8a2be2"
            radius: 17

            // Внутренняя таблица (черная)
            Rectangle {
                anchors.centerIn: parent
                width: 800
                height: 450

                color: "#000000"
                radius: 15
                clip: true // Обрезаем содержимое по скругленным углам

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

                            // Ширины подогнаны под 800px: 60+200+120+140+130+150 = 800
                            Item {
                                width: 60; height: parent.height
                                Text {
                                    text: "ID"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                            Item {
                                width: 200; height: parent.height
                                Text {
                                    text: "ФИО"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                            Item {
                                width: 120; height: parent.height
                                Text {
                                    text: "Дата"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                            Item {
                                width: 140; height: parent.height
                                Text {
                                    text: "Марка"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                            Item {
                                width: 130; height: parent.height
                                Text {
                                    text: "Цена"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                            Item {
                                width: 150; height: parent.height
                                Text {
                                    text: "Статус"; color: "#FFFFFF"; font.bold: true; font.pixelSize: 14; anchors.centerIn: parent
                                }
                            }
                        }
                    }

                    // --- СПИСОК ДАННЫХ ---
                    ScrollView {
                        width: parent.width
                        height: parent.height - 40
                        clip: true

                        Column {
                            width: parent.width
                            spacing: 0

                            property var dataList: [
                                {
                                    id: 1,
                                    fio: "Иванов И.И.",
                                    date: "12.04.2026",
                                    brand: "Toyota Camry",
                                    price: "5 000 ₽",
                                    status: "Новая"
                                },
                                {
                                    id: 2,
                                    fio: "Петров П.П.",
                                    date: "13.04.2026",
                                    brand: "BMW X5",
                                    price: "12 500 ₽",
                                    status: "В работе"
                                },
                                {
                                    id: 3,
                                    fio: "Сидоров С.С.",
                                    date: "10.04.2026",
                                    brand: "Lada Vesta",
                                    price: "2 000 ₽",
                                    status: "Готов"
                                },
                                {
                                    id: 4,
                                    fio: "Кузнецова А.А.",
                                    date: "15.04.2026",
                                    brand: "Kia Rio",
                                    price: "8 000 ₽",
                                    status: "Отменён"
                                },
                                {
                                    id: 5,
                                    fio: "Смирнов А.Д.",
                                    date: "11.04.2026",
                                    brand: "Hyundai",
                                    price: "4 500 ₽",
                                    status: "Новая"
                                }
                            ]

                            Repeater {
                                model: parent.dataList

                                delegate: Row {
                                    width: parent.width
                                    height: 40

                                    Rectangle {
                                        anchors.fill: parent
                                        color: (index % 2 === 0) ? "#050505" : "#000000"
                                    }

                                    // ID
                                    Item {
                                        width: 60; height: parent.height
                                        Text {
                                            text: modelData.id; color: "#d05ce3"; font.pixelSize: 14; anchors.centerIn: parent
                                        }
                                    }
                                    // ФИО
                                    Item {
                                        width: 200; height: parent.height
                                        Text {
                                            text: modelData.fio; color: "#d05ce3"; font.pixelSize: 14; anchors.centerIn: parent; elide: Text.ElideRight
                                        }
                                    }
                                    // Дата
                                    Item {
                                        width: 120; height: parent.height
                                        Text {
                                            text: modelData.date; color: "#d05ce3"; font.pixelSize: 14; anchors.centerIn: parent
                                        }
                                    }
                                    // Марка
                                    Item {
                                        width: 140; height: parent.height
                                        Text {
                                            text: modelData.brand; color: "#d05ce3"; font.pixelSize: 14; anchors.centerIn: parent; elide: Text.ElideRight
                                        }
                                    }
                                    // Цена
                                    Item {
                                        width: 130; height: parent.height
                                        Text {
                                            text: modelData.price; color: "#d05ce3"; font.pixelSize: 14; anchors.centerIn: parent
                                        }
                                    }

                                    // === СТАТУС С ВЫБОРОМ ===
                                    Item {
                                        width: 150; height: parent.height

                                        ComboBox {
                                            id: status
                                            model: [" ", "В работе", "Готов", "Отменен"]
                                            textRole: "name"
                                            width: 100
                                            height: 45

                                            background: Rectangle {
                                                color: "#000000"
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
                                        }

                                        // ============================

                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            width: parent.width
                                            height: 1
                                            color: "#333333"
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
}