import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import styles 1.0

Item {
    id: almanac
    property string label: "Дата"
    property var calendarWidth: 300
    property var calendarHeight: 300
    property alias selectedDate: calendar.selectedDate

    Column {
        spacing: 5

        Text {
            text: label
            color: Colors.main
            font.pixelSize: 13
            font.bold: true
        }

        Item {
            width: almanac.width
            height: almanac.height

            Rectangle {
                color: Colors.substrate
                border.color: Colors.main
                border.width: 2
                radius: 8
                anchors.fill: parent
            }

            Text {
                leftPadding: 12
                rightPadding: 30
                text: Qt.formatDate(calendar.selectedDate, "dd.MM.yyyy")
                color: Colors.additional
                font.pixelSize: 14
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: popup.open()
            }
        }
    }

    Popup {
        id: popup
        modal: true
        focus: true
        width: parent.width
        height: parent.height

        background: Rectangle { color: 'transparent' }

        Substrate {
            id: substrate
            width: calendarWidth
            height: calendarHeight

            Calendar {
                id: calendar
                width: parent.width * 0.95
                height: parent.height * 0.95
                anchors.centerIn: parent

                minimumDate: new Date(2000, 0, 1)
                maximumDate: new Date()

                style: CalendarStyle {
                    gridColor: 'transparent'

                    background: Rectangle { color: 'transparent' }

                    navigationBar: Rectangle {
                        height: substrate.height * 0.1
                        color: 'transparent'
                        Item {
                            anchors.fill: parent

                            ImageButton {
                                height: parent.height
                                width: parent.height
                                anchors.left: parent.left

                                imgHeight: parent.height * 0.8
                                imgWidth: parent.height * 0.8
                                imgBaseColor: Colors.main
                                imgHoverColor: Colors.additional
                                hoverColor: 'transparent'
                                imgSource: "qrc:/resources/right_arrow.png"

                                onClicked: calendar.showPreviousMonth()
                            }

                            TabText {
                                anchors.centerIn: parent
                                color: Colors.main
                                text: styleData.title
                                font.pixelSize: parent.height * 0.6
                            }

                            ImageButton {
                                height: parent.height
                                width: parent.height
                                anchors.right: parent.right

                                imgHeight: parent.height * 0.8
                                imgWidth: parent.height * 0.8
                                imgBaseColor: Colors.main
                                imgHoverColor: Colors.additional
                                hoverColor: 'transparent'
                                imgSource: "qrc:/resources/left_arrow.png"

                                onClicked: calendar.showNextMonth()
                            }
                        }

                        Rectangle {
                            width: substrate.width * 0.99
                            height: 2
                            color: Colors.main
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    dayDelegate: Rectangle {
                        width: substrate.width * 0.1
                        height: substrate.height * 0.1
                        radius: 4

                        color: styleData.selected ? Colors.main
                            : styleData.visibleMonth ? Colors.background
                                : Colors.lighterSubstrate

                        TabText {
                            anchors.centerIn: parent
                            text: styleData.date.getDate()
                            font.pixelSize: parent.height * 0.4
                        }
                    }

                    dayOfWeekDelegate: Rectangle {
                        width: substrate.width * 0.1
                        height: substrate.height * 0.1
                        color: 'transparent'

                        TabText {
                            anchors.centerIn: parent
                            text: Qt.locale().dayName(styleData.dayOfWeek, Locale.ShortFormat)
                            color: (styleData.dayOfWeek === 0 || styleData.dayOfWeek === 6) ? Colors.additional : Colors.text
                            font.pixelSize: parent.height * 0.4
                        }
                    }
                }

                onClicked: {
                    selectedDate: calendar.selectedDate
                    popup.close()
                }
            }
        }

    }
}
