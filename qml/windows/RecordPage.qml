import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: recordPage
    anchors.fill: parent

    //при переделке оставить onClicked и айдишники
    ScrollView {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: 20
            padding: 20

            Item {
                width: 1
                height: 5
            }

            Row {
                spacing: 10

                TextField {
                    id: lastName
                    placeholderText: "Фамилия"
                    width: 280
                    height: 45
                    font.pixelSize: 16


                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12

                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }

                TextField {
                    id: firstName
                    placeholderText: "Имя"
                    width: 280
                    height: 45
                    font.pixelSize: 16

                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12
                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }

                TextField {
                    id: middleName
                    placeholderText: "Отчество"
                    width: 280
                    height: 45
                    font.pixelSize: 16


                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12
                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }


            // Контакты
            Row {
                spacing: 30


                TextField {
                    id: phoneNumber
                    placeholderText: "Номер телефона"
                    width: 415
                    height: 45
                    font.pixelSize: 16

                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12
                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }

                TextField {
                    id: email
                    placeholderText: "Электронная почта"
                    width: 415
                    height: 45
                    font.pixelSize: 16

                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12
                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }


            Rectangle {
                width: 900
                height: 15
                color: "transparent"
            }


            // МАШИНА
            Row {
                spacing: 30

                ComboBox {
                    id: carBrand
                    width: 415
                    height: 45
                    model: ["Марка машины", "Toyota", "BMW", "Audi", "Lada"]
                    currentIndex: 0

                    // Фон поля
                    background: Rectangle {
                        z: 0
                        color: "#000000"
                        border.color: "#8a2be2"
                        border.width: 2
                        radius: 12
                    }

                    // Текст внутри поля
                    contentItem: Text {
                        leftPadding: 15
                        rightPadding: 40
                        text: parent.displayText

                        color: parent.currentIndex === 0 ? "#8a2be2" : "#d05ce3"

                        font.pixelSize: 16

                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        z: 1
                    }

                    // Стрелка
                    indicator: Canvas {
                        x: parent.width - width - 15
                        y: parent.height / 2 - height / 2
                        width: 12
                        height: 8
                        contextType: "2d"
                        z: 2

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

                    // Элементы списка
                    delegate: ItemDelegate {
                        width: parent.width
                        highlighted: ListView.isCurrentItem

                        contentItem: Text {
                            text: modelData
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

                TextField {
                    id: carModel
                    placeholderText: "Модель машины"
                    width: 415
                    height: 45
                    font.pixelSize: 16

                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    leftPadding: 15
                    rightPadding: 15
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        border.width: 2
                        radius: 12
                        border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                        Behavior on border
                        .
                        color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }


            Rectangle {
                width: 900
                height: 15
                color: "transparent"
            }


            Row {
                spacing: 30

                //УСЛУГИ
                ComboBox {
                    model: ["Услуги", "ТО", "Ремонт двигателя", "Замена масла"]
                    width: 415
                    height: 45


                    // Фон поля
                    background: Rectangle {
                        z: 0
                        color: "#000000"
                        border.color: "#8a2be2"
                        border.width: 2
                        radius: 12
                    }

                    // Текст внутри поля
                    contentItem: Text {
                        leftPadding: 15
                        rightPadding: 40
                        text: parent.displayText

                        color: parent.currentIndex === 0 ? "#8a2be2" : "#d05ce3"

                        font.pixelSize: 16

                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        z: 1
                    }

                    // Стрелка
                    indicator: Canvas {
                        x: parent.width - width - 15
                        y: parent.height / 2 - height / 2
                        width: 12
                        height: 8
                        contextType: "2d"
                        z: 2

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

                    // Элементы списка
                    delegate: ItemDelegate {
                        width: parent.width
                        highlighted: ListView.isCurrentItem

                        contentItem: Text {
                            text: modelData
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

                // МАСТЕР
                ComboBox {
                    model: ["Мастер", "Иванов И.И.", "Петров П.П.", "Сидоров С.С."]
                    width: 415
                    height: 45


                    // Фон поля
                    background: Rectangle {
                        z: 0
                        color: "#000000"
                        border.color: "#8a2be2"
                        border.width: 2
                        radius: 12
                    }

                    // Текст внутри поля
                    contentItem: Text {
                        leftPadding: 15
                        rightPadding: 40
                        text: parent.displayText

                        color: parent.currentIndex === 0 ? "#8a2be2" : "#d05ce3"

                        font.pixelSize: 16

                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        z: 1
                    }

                    // Стрелка
                    indicator: Canvas {
                        x: parent.width - width - 15
                        y: parent.height / 2 - height / 2
                        width: 12
                        height: 8
                        contextType: "2d"
                        z: 2

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

                    // Элементы списка
                    delegate: ItemDelegate {
                        width: parent.width
                        highlighted: ListView.isCurrentItem

                        contentItem: Text {
                            text: modelData
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
            }


            // ПРИМЕРНАЯ ЦЕНА (только просмотр)
            TextField {
                placeholderText: "Примерная цена"
                readOnly: true
                width: 280
                height: 45
                font.pixelSize: 16


                color: "#d05ce3"
                placeholderTextColor: "#8a2be2"

                leftPadding: 15
                rightPadding: 15
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    anchors.fill: parent
                    color: "#000000"
                    border.width: 2
                    radius: 12

                    border.color: parent.focus ? "#d05ce3" : "#8a2be2"
                    Behavior on border.color {ColorAnimation {duration: 200}}
                }
            }

            // КОММЕНТАРИЙ
            ScrollView {
                width: 855
                height: 120
                font.pixelSize: 16
                clip: true

                background: Rectangle {
                    color: "#000000"
                    border.color: comment.focus ? "#d05ce3" : "#8a2be2"
                    border.width: 2
                    radius: 12

                    Behavior on border
                    .
                    color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }

                //область ввода
                TextArea {
                    id: comment
                    placeholderText: "Комментарий"
                    width: parent.width
                    height: Math.max(implicitHeight, parent.height)

                    color: "#d05ce3"
                    placeholderTextColor: "#8a2be2"

                    wrapMode: Text.WrapAnywhere
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop

                    leftPadding: 15
                    rightPadding: 15
                    topPadding: 10
                    bottomPadding: 10

                    background: Item {
                    }
                }
            }

            //КНОПКА

            Row {
                spacing: 30

                Item {
                    width: 630
                    height: 1
                }

                Button {
                    id: submitBtn
                    text: "Отправить"
                    width: 180
                    height: 40

                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: parent.pressed ? "#8a2be2" : "#ffffff"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }
                    }

                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40

                        color: parent.pressed ? "#000000" : "#8a2be2"

                        border.color: parent.pressed ? "#8a2be2" : "transparent"
                        border.width: 2

                        radius: 12
                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }
                        Behavior on border.color {ColorAnimation {duration: 150}}
                    }

                    onClicked: {
                        recordPageLogic.addRecordInDataBase(
                            lastName.text + " " + firstName.text + " " + middleName.text,
                            phoneNumber.text,
                            email.text,
                            "dfdfdfd",
                            carModel.text,
                            comment.text,
                            "dfdfdfd",
                            "dsfdsfsdf",
                            "fsddsfsdf"
                        )
                    }
                }
            }
        }
    }
}

