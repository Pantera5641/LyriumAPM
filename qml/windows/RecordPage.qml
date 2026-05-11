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
        spacing: parent.height * 0.03

        Item {
            width: recordPage.width
            height: recordPage.height * 0.05
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: recordPage.width * 0.02
            anchors.rightMargin: recordPage.width * 0.02
            spacing: recordPage.width * 0.01

            BaseTextField {
                id: lastName
                placeholderText: "Фамилия"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }

            BaseTextField {
                id: firstName
                placeholderText: "Имя"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }

            BaseTextField {
                id: middleName
                placeholderText: "Отчество"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }
        }

        // Контакты
        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: recordPage.width * 0.02
            anchors.rightMargin: recordPage.width * 0.02
            spacing: recordPage.width * 0.03

            BaseTextField {
                id: phoneNumber
                placeholderText: "Номер телефона"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }

            BaseTextField {
                id: email
                placeholderText: "Электронная почта"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }
        }

        Rectangle {
            width: recordPage.width
            height: recordPage.height * 0.025
            color: "transparent"
        }

        // МАШИНА
        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: recordPage.width * 0.02
            anchors.rightMargin: recordPage.width * 0.02
            spacing: recordPage.width * 0.03

            BaseComboBox {
                id: carBrand
                baseText: "Выбрать марку автомобиля"
                model: carBrandModel
                textRole: "name"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }

            BaseTextField {
                id: carModel
                placeholderText: "Модель машины"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }
        }

        Rectangle {
            width: recordPage.width
            height: recordPage.height * 0.025
            color: "transparent"
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: recordPage.width * 0.02
            anchors.rightMargin: recordPage.width * 0.02
            spacing: recordPage.width * 0.03

            //УСЛУГИ
            BaseComboBox {
                id: services
                baseText: "Выбрать услгугу"
                model: servicesModel
                textRole: "name"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07

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
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.preferredHeight: recordPage.height * 0.07
            }
        }

        // ПРИМЕРНАЯ ЦЕНА (только просмотр)
        BaseTextField {
            id: priceBox
            placeholderText: "Примерная цена"
            readOnly: true

            anchors.left: parent.left
            anchors.leftMargin: recordPage.width * 0.02
            width: recordPage.width * 0.3
            height: recordPage.height * 0.07
        }

        // КОММЕНТАРИЙ
        ScrollView {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: recordPage.width * 0.02
            anchors.rightMargin: recordPage.width * 0.02
            height: recordPage.height * 0.18

            font.pixelSize: priceBox.height * 0.35
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            background: Rectangle {
                color: Colors.substrate
                border.color: comment.focus ? Colors.additional : Colors.main
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

                color: Colors.additional
                placeholderTextColor: Colors.main

                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop

                leftPadding: 15
                rightPadding: 15
                topPadding: 10
                bottomPadding: 10

                background: Item {}
            }
        }

        //КНОПКА
        Button {
            id: submitBtn
            text: "Отправить"

            width: recordPage.width * 0.2
            height: recordPage.height * 0.06
            anchors.right: parent.right
            anchors.rightMargin: recordPage.width * 0.02

            hoverEnabled: false

            contentItem: Text {
                text: parent.text
                font.bold: true
                font.pixelSize: submitBtn.height * 0.45
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
                implicitWidth: submitBtn.width * 0.55
                implicitHeight: submitBtn.height

                color: parent.pressed ? Colors.substrate : Colors.main

                border.color: parent.pressed ? Colors.main : "transparent"
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