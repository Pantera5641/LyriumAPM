import QtQuick
import QtQuick.Controls

Item {
    id: recordPage
    anchors.fill: parent

    //при переделке оставить onClicked и айдишники
    ScrollView {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: 10
            padding: 10

            // ФИО
            TextField {
                id: lastName
                placeholderText: "Фамилия"
            }
            TextField {
                id: firstName
                placeholderText: "Имя"
            }
            TextField {
                id: middleName
                placeholderText: "Отчество"
            }

            // Контакты
            TextField {
                id: phoneNumber
                placeholderText: "Номер телефона"
            }
            TextField {
                id: email
                placeholderText: "Электронная почта"
            }

            // Машина
            ComboBox {
                model: ["Toyota", "BMW", "Audi", "Lada"]
            }

            TextField {
                id: carModel
                placeholderText: "Модель машины"
            }

            // Услуги
            ComboBox {
                model: ["ТО", "Ремонт двигателя", "Замена масла"]
            }

            // Мастер
            ComboBox {
                model: ["Иванов И.И.", "Петров П.П.", "Сидоров С.С."]
            }

            // Примерная цена (только просмотр)
            TextField {
                placeholderText: "Примерная цена"
                readOnly: true
            }

            // Комментарий
            TextArea {
                id: comment
                placeholderText: "Комментарий"
                height: 100
            }

            Button {
                text: "Отправить"
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