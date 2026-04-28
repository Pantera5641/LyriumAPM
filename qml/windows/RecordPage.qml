import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: recordPage
    Layout.fillWidth: true
    Layout.fillHeight: true

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
                baseText: "Выбрать марку автомобиля"
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
                baseText: "Выбрать услгугу"
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
                baseText: "Выбрать мастера"
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
                    carBrand.currentIndex = 0;
                    carModel.text = "";
                    comment.text = "";
                    employee.currentIndex = 0;
                    services.currentIndex = 0;
                    priceBox.text = "";
                    databaseModel.update()
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

                    return "+7 (" + part1 + ") " + part2 + "-" + part3 + "-"  + part4;
                }
            }
        }
    }
}