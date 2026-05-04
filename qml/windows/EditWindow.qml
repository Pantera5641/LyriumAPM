import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import styles 1.0
import "../components"

Window {
    id: editOrderWindow
    width: 500
    height: 800
    minimumWidth: 420
    minimumHeight: 750
    modality: Qt.ApplicationModal
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.Dialog
    color: "transparent"

    property var recordId : 0
    property var orderData: databaseModel.getById(recordId)
    property bool isValid: true

    MouseArea {
        width: parent.width
        height: parent.height * 0.1
        onPressed: editOrderWindow.startSystemMove()
    }

    Rectangle {
        anchors.fill: parent
        color: Colors.background
        radius: 8

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15


            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "transparent"

                Text {
                    text: "Заказ  №" + recordId
                    color: Colors.main
                    font.bold: true
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 2
                    color: Colors.main
                }

                Rectangle {
                    width: 40
                    height: 40
                    color: "transparent"
                    radius: 8
                    border.color: Colors.main
                    border.width: 2

                    Image {
                        anchors.centerIn: parent
                        width: 25
                        height: 25
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
                            reportsBuilder.createRecordReport(recordId)
                            reportsBuilder.openReportsFolder()
                        }
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    SectionHeader { text: "Информация о клиенте" }

                    LabeledTextField {
                        id: clientNameField
                        label: "ФИО клиента"
                        text: orderData.clientFullName
                        Layout.fillWidth: true
                        readOnly: true
                    }

                    LabeledTextField {
                        id: clientPhoneField
                        label: "Телефон"
                        text: orderData.phoneNumber
                        Layout.fillWidth: true

                        onTextChanged: {
                            isValid = validate();
                        }
                    }

                    LabeledTextField {
                        id: clientEmailField
                        label: "Email"
                        text: orderData.email
                        Layout.fillWidth: true

                        onTextChanged: {
                            isValid = validate();
                        }
                    }

                    SectionHeader { text: "Информация об автомобиле" }

                    TextFieldAndComboBox{
                        id: carBrandBox
                        topText: "Марка автомобиля"
                        fieldText: orderData.carBrand
                        comboBoxModel: carBrandModel
                        Layout.fillWidth: true

                        onModelIdChanged: {
                            isValid = validate();
                        }
                    }

                    LabeledTextField {
                        id: carModelField
                        label: "Модель автомобиля"
                        text: orderData.carModel
                        Layout.fillWidth: true

                        onTextChanged: {
                            isValid = validate();
                        }
                    }

                    SectionHeader { text: "Услуга" }
                    TextFieldAndComboBox{
                        id: servicesBox
                        topText: "Услуга"
                        fieldText: orderData.serviceProvided
                        comboBoxModel: servicesModel
                        Layout.fillWidth: true

                        onModelIdChanged: {
                            priceField.text = recordPageLogic.getPrice(servicesModel.getTag(servicesBox.modelId)) + "₽"
                            isValid = validate();
                        }
                    }

                    LabeledTextField {
                        id: priceField
                        label: "Цена"
                        text: orderData.price
                        readOnly: true
                        Layout.fillWidth: true
                    }

                    SectionHeader { text: "Информация о мастере" }
                    TextFieldAndComboBox{
                        id: masterField
                        topText: "Мастер"
                        fieldText: orderData.masterFullName
                        comboBoxModel: employeeModel
                        Layout.fillWidth: true

                        onModelIdChanged: {
                            isValid = validate();
                        }
                    }

                    SectionHeader { text: "Информация о заказе" }
                    Almanac {
                        id: almanac
                        selectedDate: parseDate(orderData.date)
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                    }

                    Rectangle{
                        color: "transparent"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 5
                    }

                    TextFieldAndComboBox{
                        id: statusBox
                        topText: "Статус"
                        fieldText: orderData.status
                        comboBoxModel: statusModel
                        Layout.fillWidth: true
                    }

                    ColumnLayout {
                        id: commentField
                        Layout.fillWidth: true
                        Layout.preferredHeight: 120
                        spacing: 5

                        Text {
                            text: "Примечания"
                            color: Colors.main
                            font.pixelSize: 13
                            font.bold: true
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Colors.substrate
                            radius: 8
                            border.color: textArea.focus ? Colors.additional : Colors.main
                            border.width: 2
                            ScrollView {
                                anchors.fill: parent
                                anchors.margins: 1
                                clip: true
                                TextArea {
                                    id: textArea
                                    width: parent.width
                                    text: orderData.comment
                                    color: Colors.additional
                                    font.pixelSize: 14
                                    wrapMode: TextEdit.Wrap
                                    placeholderTextColor: Colors.main
                                    background: Item{}
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#333333"
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                spacing: 15

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    color: "transparent"
                    radius: 8
                    border.color: Colors.main
                    border.width: 2

                    Text {
                        text: "Отмена"
                        color: Colors.main
                        font.bold: true
                        font.pixelSize: 14
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: editOrderWindow.close()
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    color: Colors.main
                    radius: 8
                    opacity: isValid ? 1.0 : 0.5

                    Text {
                        text: "Сохранить"
                        color: Colors.text
                        font.bold: true
                        font.pixelSize: 14
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        enabled: isValid

                        onClicked: {
                            let valid = true;
                            if(!valid) return;

                            databaseModel.setValueByIdTag(recordId, "client_name", clientNameField.text);
                            databaseModel.setValueByIdTag(recordId, "phone_number", formatPhoneToPretty(clientPhoneField.text));
                            databaseModel.setValueByIdTag(recordId, "email", clientEmailField.text);
                            databaseModel.setValueByIdTag(recordId, "car_brand_name", carBrandModel.getTag(carBrandBox.modelId));
                            databaseModel.setValueByIdTag(recordId, "car_model", carModelField.text);
                            databaseModel.setValueByIdTag(recordId, "comment", commentField.text);
                            databaseModel.setValueByIdTag(recordId, "master_name", employeeModel.getTag(masterField.modelId));
                            databaseModel.setValueByIdTag(recordId, "service_provided", servicesModel.getTag(servicesBox.modelId));
                            databaseModel.setValueByIdTag(recordId, "repair_amount", recordPageLogic.getPrice(servicesModel.getTag(servicesBox.modelId)));
                            databaseModel.setValueByIdTag(recordId, "visit_date", Qt.formatDate(almanac.selectedDate, "yyyy.MM.dd"));
                            databaseModel.setValueByIdTag(recordId, "status", statusModel.getTag(statusBox.modelId));

                            databaseModel.update(sortTagModel.getTag(sortBox.currentIndex), "");
                            editOrderWindow.close();
                        }
                    }
                }
            }
        }
    }

    function parseDate(str) {
        const items = str.split(".");
        const day = parseInt(items[0], 10);
        const month = parseInt(items[1], 10) - 1;
        const year = parseInt(items[2], 10);
        return new Date(year, month, day)
    }

    function validate() {
        let valid = true;
        valid = validatePhone(clientPhoneField)&& valid;
        valid = validateEmail(clientEmailField) && valid;
        valid = validateComboBox(carBrandBox) && valid;
        valid = validateName(carModelField) && valid;
        valid = validateComboBox(masterField) && valid;
        valid = validateComboBox(servicesBox) && valid;

        return valid;
    }

    function validateName(name) {
        const re = /^[a-zA-Z0-9а-яА-ЯёЁ]+$/;
        if (name.text && re.test(name.text.trim())) {
            return true;
        }
        return false;
    }

    function validateComboBox(box)
    {
        if (box.modelId !== -1) {
            return true;
        }
        return false;
    }

    function validatePhone(phone) {
        const re = /^(\+7|8)\s?\(?\d{3}\)?\s?\d{3}[-\s]?\d{2}[-\s]?\d{2}$/;
        if (phone.text && re.test(phone.text.trim())) {
            return true;
        }
        return false;
    }

    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
        if (email.text && re.test(email.text.trim())) {
            return true;
        }
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