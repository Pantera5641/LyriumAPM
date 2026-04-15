import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Window {
    id: editOrderWindow
    width: 600
    height: 800
    minimumWidth: 550
    minimumHeight: 750
    modality: Qt.ApplicationModal
    flags: Qt.FramelessWindowHint | Qt.Dialog  // ← Убираем заголовок
    color: "#121212"
    title: "Редактирование заказа"

    property var orderData: null
    signal orderSaved(var updatedData)

    Rectangle {
        anchors.fill: parent
        color: "#121212"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color: "transparent"

                Text {
                    text: orderData ? "Заказ  #" + orderData.id : "Новый заказ"
                    color: "#8a2be2"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 2
                    color: "#8a2be2"
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                ColumnLayout {
                    width: parent.width - 10
                    spacing: 15

                    SectionHeader { text: "Информация о клиенте" }

                    LabeledTextField {
                        id: clientNameField
                        label: "ФИО клиента"
                        text: orderData ? (orderData.clientName || "") : ""
                        Layout.fillWidth: true
                    }

                    LabeledTextField {
                        id: clientPhoneField
                        label: "Телефон"
                        text: orderData ? (orderData.clientPhone || "") : ""
                        Layout.fillWidth: true
                    }

                    LabeledTextField {
                        id: clientEmailField
                        label: "Email"
                        text: orderData ? (orderData.clientEmail || "") : ""
                        Layout.fillWidth: true
                    }

                    SectionHeader { text: "Информация об автомобиле" }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Марка автомобиля"
                            color: "#8a2be2"
                            font.pixelSize: 13
                            font.bold: true
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 280
                                Layout.preferredHeight: 45
                                color: "#1a1a1a"
                                radius: 8
                                border.color: "#8a2be2"
                                border.width: 2

                                Text {
                                    id: currentCarBrand
                                    anchors.fill: parent
                                    anchors.margins: 1
                                    text: orderData ? (orderData.carBrand || "Не выбрано") : "Не выбрано"
                                    color: "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    leftPadding: 12
                                    elide: Text.ElideRight
                                }
                            }

                            ComboBox {
                                id: carBrandField
                                model: carBrandModel
                                textRole: "name"
                                Layout.preferredWidth: 170
                                Layout.preferredHeight: 45
                                currentIndex: -1
                                displayText: currentIndex === -1 ? "Изменить" : currentText

                                background: Rectangle {
                                    color: "#000000"
                                    border.color: "#8a2be2"
                                    border.width: 2
                                    radius: 8
                                }

                                contentItem: Text {
                                    leftPadding: 12
                                    rightPadding: 30
                                    text: parent.displayText
                                    color: parent.currentIndex === -1 ? "#8a2be2" : "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                indicator: Canvas {
                                    x: parent.width - width - 12
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

                                delegate: ItemDelegate {
                                    width: ListView.view.width
                                    highlighted: ListView.isCurrentItem
                                    contentItem: Text {
                                        text: name
                                        color: "#ffffff"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                    background: Rectangle {
                                        color: highlighted ? "#3d0e69" : "#09020f"
                                    }
                                }
                            }
                        }
                    }

                    LabeledTextField {
                        id: carModelField
                        label: "Модель автомобиля"
                        text: orderData ? (orderData.carModel || "") : ""
                        Layout.fillWidth: true
                    }

                    SectionHeader { text: "Услуга" }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Услуга"
                            color: "#8a2be2"
                            font.pixelSize: 13
                            font.bold: true
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 280
                                Layout.preferredHeight: 45
                                color: "#1a1a1a"
                                radius: 8
                                border.color: "#8a2be2"
                                border.width: 2

                                Text {
                                    id: currentService
                                    anchors.fill: parent
                                    anchors.margins: 1
                                    text: orderData ? (orderData.serviceName || "Не выбрано") : "Не выбрано"
                                    color: "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    leftPadding: 12
                                    elide: Text.ElideRight
                                }
                            }

                            ComboBox {
                                id: serviceField
                                model: servicesModel
                                textRole: "name"
                                Layout.preferredWidth: 170
                                Layout.preferredHeight: 45
                                currentIndex: -1
                                displayText: currentIndex === -1 ? "Изменить" : currentText

                                background: Rectangle {
                                    color: "#000000"
                                    border.color: "#8a2be2"
                                    border.width: 2
                                    radius: 8
                                }

                                contentItem: Text {
                                    leftPadding: 12
                                    rightPadding: 30
                                    text: parent.displayText
                                    color: parent.currentIndex === -1 ? "#8a2be2" : "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                indicator: Canvas {
                                    x: parent.width - width - 12
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

                                delegate: ItemDelegate {
                                    width: ListView.view.width
                                    highlighted: ListView.isCurrentItem
                                    contentItem: Text {
                                        text: name
                                        color: "#ffffff"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                    background: Rectangle {
                                        color: highlighted ? "#3d0e69" : "#09020f"
                                    }
                                }

                                onActivated: {
                                    if (currentIndex !== -1) {
                                        var serviceTag = servicesModel.get(currentIndex).tag
                                        var price = recordPageLogic.getPrice(serviceTag)
                                        priceField.text = price + "₽"
                                    }
                                }
                            }
                        }
                    }

                    SectionHeader { text: "Информация о мастере" }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Мастер"
                            color: "#8a2be2"
                            font.pixelSize: 13
                            font.bold: true
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 280
                                Layout.preferredHeight: 45
                                color: "#1a1a1a"
                                radius: 8
                                border.color: "#8a2be2"
                                border.width: 2

                                Text {
                                    id: currentMaster
                                    anchors.fill: parent
                                    anchors.margins: 1
                                    text: orderData ? (orderData.masterName || "Не выбрано") : "Не выбрано"
                                    color: "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    leftPadding: 12
                                    elide: Text.ElideRight
                                }
                            }

                            ComboBox {
                                id: masterField
                                model: employeeModel
                                textRole: "name"
                                Layout.preferredWidth: 170
                                Layout.preferredHeight: 45
                                currentIndex: -1
                                displayText: currentIndex === -1 ? "Изменить" : currentText

                                background: Rectangle {
                                    color: "#000000"
                                    border.color: "#8a2be2"
                                    border.width: 2
                                    radius: 8
                                }

                                contentItem: Text {
                                    leftPadding: 12
                                    rightPadding: 30
                                    text: parent.displayText
                                    color: parent.currentIndex === -1 ? "#8a2be2" : "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                indicator: Canvas {
                                    x: parent.width - width - 12
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

                                delegate: ItemDelegate {
                                    width: ListView.view.width
                                    highlighted: ListView.isCurrentItem
                                    contentItem: Text {
                                        text: name
                                        color: "#ffffff"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                    background: Rectangle {
                                        color: highlighted ? "#3d0e69" : "#09020f"
                                    }
                                }
                            }
                        }
                    }

                    SectionHeader { text: "Информация о заказе" }

                    LabeledTextField {
                        id: dateField
                        label: "Дата"
                        text: orderData ? (orderData.date || "") : Qt.formatDate(new Date(), "dd.MM.yyyy")
                        Layout.fillWidth: true
                    }

                    LabeledTextField {
                        id: priceField
                        label: "Цена"
                        text: orderData ? (orderData.price || "") : ""
                        Layout.fillWidth: true
                        readOnly: true
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Статус"
                            color: "#8a2be2"
                            font.pixelSize: 13
                            font.bold: true
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 280
                                Layout.preferredHeight: 45
                                color: "#1a1a1a"
                                radius: 8
                                border.color: "#8a2be2"
                                border.width: 2

                                Text {
                                    id: currentStatus
                                    anchors.fill: parent
                                    anchors.margins: 1
                                    text: orderData ? (orderData.status || "Принята") : "Принята"
                                    color: "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    leftPadding: 12
                                    elide: Text.ElideRight
                                }
                            }

                            ComboBox {
                                id: statusField
                                model: statusModel
                                textRole: "name"
                                Layout.preferredWidth: 170
                                Layout.preferredHeight: 45
                                currentIndex: -1
                                displayText: currentIndex === -1 ? "Изменить" : currentText

                                background: Rectangle {
                                    color: "#000000"
                                    border.color: "#8a2be2"
                                    border.width: 2
                                    radius: 8
                                }

                                contentItem: Text {
                                    leftPadding: 12
                                    rightPadding: 30
                                    text: parent.displayText
                                    color: parent.currentIndex === -1 ? "#8a2be2" : "#d05ce3"
                                    font.pixelSize: 14
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                indicator: Canvas {
                                    x: parent.width - width - 12
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

                                delegate: ItemDelegate {
                                    width: ListView.view.width
                                    highlighted: ListView.isCurrentItem
                                    contentItem: Text {
                                        text: name
                                        color: "#ffffff"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        color: highlighted ? "#3d0e69" : "#09020f"
                                    }
                                }
                            }
                        }
                    }

                    LabeledTextArea {
                        id: descriptionField
                        label: "Примечания"
                        text: orderData && orderData.comment ? orderData.comment : ""
                        Layout.fillWidth: true
                        Layout.preferredHeight: 120
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
                    border.color: "#8a2be2"
                    border.width: 2

                    Text {
                        text: "Отмена"
                        color: "#8a2be2"
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
                    color: "#8a2be2"
                    radius: 8
                    opacity: (clientNameField.text.length > 0 && dateField.text.length > 0) ? 1.0 : 0.5

                    Text {
                        text: "Сохранить"
                        color: "#FFFFFF"
                        font.bold: true
                        font.pixelSize: 14
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: clientNameField.text.length > 0 && dateField.text.length > 0
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            var carBrandValue = carBrandField.currentIndex !== -1 ? carBrandField.currentText : currentCarBrand.text
                            var serviceValue = serviceField.currentIndex !== -1 ? serviceField.currentText : currentService.text
                            var masterValue = masterField.currentIndex !== -1 ? masterField.currentText : currentMaster.text
                            var statusValue = statusField.currentIndex !== -1 ? statusField.currentText : currentStatus.text

                            var dataToSave = {
                                id: orderData ? orderData.id : 0,
                                clientName: clientNameField.text,
                                clientPhone: clientPhoneField.text,
                                clientEmail: clientEmailField.text,
                                carBrand: carBrandValue,
                                carModel: carModelField.text,
                                serviceName: serviceValue,
                                masterName: masterValue,
                                date: dateField.text,
                                price: priceField.text,
                                status: statusValue,
                                comment: descriptionField.text
                            }

                            // вставить хуйню для сохранения
                            saveClicked(dataToSave)
                            editOrderWindow.close()
                        }
                    }
                }
            }
        }
    }

    component SectionHeader: Rectangle {
        property string text: ""
        Layout.fillWidth: true
        Layout.preferredHeight: 30
        Layout.topMargin: 5
        color: "transparent"

        Text {
            text: parent.text
            color: "#8a2be2"
            font.bold: true
            font.pixelSize: 16
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: "#8a2be2"
            opacity: 0.5
        }
    }

    component LabeledTextField: ColumnLayout {
        property string label: ""
        property alias text: textField.text
        property alias readOnly: textField.readOnly

        spacing: 5
        Layout.fillWidth: true

        Text {
            text: label
            color: "#8a2be2"
            font.pixelSize: 13
            font.bold: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: textField.readOnly ? "#1a1a1a" : "#000000"
            radius: 8
            border.color: textField.focus ? "#d05ce3" : "#8a2be2"
            border.width: 2

            TextField {
                id: textField
                anchors.fill: parent
                anchors.margins: 1
                color: "#d05ce3"
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 12
                rightPadding: 12
                background: Rectangle { color: "transparent" }
            }
        }
    }

    component LabeledTextArea: ColumnLayout {
        property string label: ""
        property alias text: textArea.text

        spacing: 5
        Layout.fillWidth: true

        Text {
            text: label
            color: "#8a2be2"
            font.pixelSize: 13
            font.bold: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#000000"
            radius: 8
            border.color: textArea.focus ? "#d05ce3" : "#8a2be2"
            border.width: 2

            ScrollView {
                anchors.fill: parent
                anchors.margins: 1
                clip: true

                TextArea {
                    id: textArea
                    color: "#d05ce3"
                    font.pixelSize: 14
                    wrapMode: TextEdit.Wrap
                    placeholderTextColor: "#8a2be2"
                    background: Rectangle { color: "transparent" }
                }
            }
        }
    }
}