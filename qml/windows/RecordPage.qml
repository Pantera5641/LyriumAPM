import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: recordPage
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

            BaseTextField {
                id: lastName
                placeholderText: "Фамилия"
                width: 280
                height: 45
            }

            BaseTextField {
                id: firstName
                placeholderText: "Имя"
                width: 280
                height: 45
            }

            BaseTextField {
                id: middleName
                placeholderText: "Отчество"
                width: 280
                height: 45
            }
        }

        // Контакты
        Row {
            spacing: 30

            BaseTextField {
                id: phoneNumber
                placeholderText: "Номер телефона"
                width: 415
                height: 45
            }

            BaseTextField {
                id: email
                placeholderText: "Электронная почта"
                width: 415
                height: 45
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

            BaseComboBox {
                id: carBrand
                model: carBrandModel
                textRole: "name"
                width: 415
                height: 45
            }

            BaseTextField {
                id: carModel
                placeholderText: "Модель машины"
                width: 415
                height: 45
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
            BaseComboBox {
                id: services
                model: servicesModel
                textRole: "name"
                width: 415
                height: 45

                onActivated: {
                    priceBox.text = recordPageLogic.getPrice(servicesModel.getTag(services.currentIndex)) + "₽"
                }
            }

            // МАСТЕР
            BaseComboBox {
                id: employee
                model: employeeModel
                textRole: "name"
                width: 415
                height: 45
            }
        }

        // ПРИМЕРНАЯ ЦЕНА (только просмотр)
        BaseTextField {
            id: priceBox
            placeholderText: "Примерная цена"
            readOnly: true
            width: 280
            height: 45
        }

        // КОММЕНТАРИЙ
        ScrollView {
            width: 855
            height: 120
            font.pixelSize: 16
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            background: Rectangle {
                color: "#000000"
                border.color: comment.focus ? "#d05ce3" : "#8a2be2"
                border.width: 2
                radius: 12

                Behavior on border.color {
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
                hoverEnabled: false

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
                        carBrandModel.getTag(carBrand.currentIndex),
                        carModel.text,
                        comment.text,
                        employeeModel.getTag(employee.currentIndex),
                        servicesModel.getTag(services.currentIndex)
                    )
                    databaseModel.update()
                }
            }
        }
    }
}