import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import styles 1.0
import "../components"

Item {
    id: recordPage
    Layout.fillWidth: true
    Layout.fillHeight: true

    Column {
        width: parent.width
        height: parent.height

        spacing: parent.width * 0.025
        padding: parent.height * 0.025

        Item {
            width: parent.width * 0.001
            height: parent.height * 0.025
        }

        Row {
            spacing: parent.width * 0.033
            width: parent.width
            height: parent.height * 0.058

            BaseTextField {
                id: lastName
                placeholderText: "Фамилия"
                width: parent.width * 0.3
                height: parent.height
            }

            BaseTextField {
                id: firstName
                placeholderText: "Имя"
                width: parent.width * 0.3
                height: parent.height       }

            BaseTextField {
                id: middleName
                placeholderText: "Отчество"
                width: parent.width * 0.3
                height: parent.height          }
        }

        // Контакты
        Row {
            spacing: parent.width * 0.046
            width: parent.width
            height: parent.height * 0.058

            BaseTextField {
                id: phoneNumber
                placeholderText: "Номер телефона"
                width: parent.width * 0.46
                height: parent.height         }

            BaseTextField {
                id: email
                placeholderText: "Электронная почта"
                width: parent.width * 0.46
                height: parent.height                  }
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.03
            color: "transparent"
        }

        // МАШИНА
        Row {
            spacing: parent.width * 0.046
            width: parent.width
            height: parent.height * 0.058

            BaseComboBox {
                id: carBrand
                baseText: "Выбрать марку автомобиля"
                model: carBrandModel
                textRole: "name"
                width: parent.width * 0.46
                height: parent.height
            }

            BaseTextField {
                id: carModel
                placeholderText: "Модель машины"
                width: parent.width * 0.46
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.03
            color: "transparent"
        }

        Row {
            spacing: parent.width * 0.046
            width: parent.width
            height: parent.height * 0.058

            //УСЛУГИ
            BaseComboBox {
                id: services
                baseText: "Выбрать услгугу"
                model: servicesModel
                textRole: "name"
                width: parent.width * 0.46
                height: parent.height

                onActivated: {
                    priceBox.text = recordPageLogic.getPrice(servicesModel.getTag(services.currentIndex)) + "₽"
                }
            }

            // МАСТЕР
            BaseComboBox {
                id: employee
                model: employeeModel
                baseText: "Выбрать мастера"
                textRole: "name"
                width: parent.width * 0.46
                height: parent.height
            }
        }

        // ПРИМЕРНАЯ ЦЕНА (только просмотр)
        Row {
            spacing: parent.width * 0.046
            width: parent.width
            height: parent.height * 0.058

            BaseTextField {
                id: priceBox
                placeholderText: "Примерная цена"
                readOnly: true
                width: parent.width * 0.4
                height: parent.height
            }
        }

        // КОММЕНТАРИЙ
        ScrollView {
            width: parent.width * 0.965
            height: parent.height * 0.18
            font.pixelSize: parent.height * 0.02
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            background: Rectangle {
                color: Colors.substrate
                border.color: comment.focus ? Colors.additional : Colors.main
                border.width: Math.max(1, recordPage.height * 0.0025)
                radius: recordPage.height * 0.015

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

                color: Colors.additional
                placeholderTextColor: Colors.main

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
            spacing: parent.width * 0.046
            width: parent.width
            height: parent.height * 0.058

            Item {
                width: parent.width * 0.72
                height: parent.height * 0.001
            }

            Button {
                id: submitBtn
                text: "Отправить"
                width: parent.width * 0.2
                height: parent.height
                hoverEnabled: false

                contentItem: Text {
                    text: parent.text
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: parent.pressed ? Colors.main : "#ffffff"

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40

                    color: parent.pressed ? Colors.substrate : Colors.main

                    border.color: parent.pressed ? Colors.main : "transparent"
                    border.width: Math.max(1, recordPage.height * 0.0025)

                    radius: recordPage.height * 0.015

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                    Behavior on border.color {ColorAnimation {duration: 150}}
                }

                onClicked: {
                    let valid = true;
                    valid = validateName(lastName) && valid;
                    valid = validateName(firstName) && valid;
                    valid = validateName(middleName) && valid;
                    valid = validatePhone(phoneNumber)&& valid;
                    valid = validateEmail(email) && valid;
                    valid = validateComboBox(carBrand) && valid;
                    valid = validateName(carModel) && valid;
                    valid = validateComboBox(employee) && valid;
                    valid = validateComboBox(services) && valid;
                    if(!valid) return;

                    recordPageLogic.addRecordInDataBase(
                        formatText(lastName.text) + " " + formatText(firstName.text) + " " + formatText(middleName.text),
                        formatPhoneToPretty(phoneNumber.text),
                        email.text,
                        carBrandModel.getTag(carBrand.currentIndex),
                        carModel.text,
                        comment.text,
                        employeeModel.getTag(employee.currentIndex),
                        servicesModel.getTag(services.currentIndex)
                    )
                    lastName.text = "";
                    firstName.text = "";
                    middleName.text = "";
                    phoneNumber.text = "";
                    email.text = "";
                    carBrand.currentIndex = -1;
                    carModel.text = "";
                    comment.text = "";
                    employee.currentIndex = -1;
                    services.currentIndex = -1;
                    priceBox.text = "";
                    databaseModel.update()
                }

                Shortcut {
                    sequence: "Return"
                    onActivated: submitBtn.clicked()
                }

                function validateName(name) {
                    const re = /^[a-zA-Z0-9а-яА-ЯёЁ]+$/;
                    if (name.text && re.test(name.text.trim())) {
                        name.error = false;
                        return true;
                    }
                    name.error = true;
                    return false;
                }

                function validateComboBox(box)
                {
                    if (box.currentIndex !== -1) {
                        box.error = false;
                        return true;
                    }
                    box.error = true;
                    return false;
                }

                function validatePhone(phone) {
                    const re = /^(\+7|8)\s?\(?\d{3}\)?\s?\d{3}[-\s]?\d{2}[-\s]?\d{2}$/;
                    if (phone.text && re.test(phone.text.trim())) {
                        phone.error = false;
                        return true;
                    }
                    phone.error = true;
                    return false;
                }

                function validateEmail(email) {
                    const re = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
                    if (email.text && re.test(email.text.trim())) {
                        email.error = false;
                        return true;
                    }
                    email.error = true;
                    return false;
                }

                function formatText(text) {
                    let t = text.trim();
                    return t.charAt(0).toUpperCase() + t.slice(1)
                }

                function formatPhoneToPretty(phone) {
                    let digits = phone;
                    digits.replace(/\D/g, "");;

                    if (digits.startsWith("8")) {
                        digits = "7" + digits.slice(1);
                    }

                    const part1 = digits.slice(1, 4);
                    const part2 = digits.slice(4, 7);
                    const part3 = digits.slice(7, 9);
                    const part4 = digits.slice(9, 11);

                    return "+7 " + part1 + " " + part2 + " " + part3 + " "  + part4;
                }
            }
        }
    }
}