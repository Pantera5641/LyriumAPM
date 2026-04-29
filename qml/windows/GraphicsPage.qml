import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.15
import "../components"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.margins: 10
            Layout.topMargin: 15

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Substrate {
                    anchors.fill: parent
                    anchors.margins: 3


                    ChartView {
                        id: chart
                        anchors.fill: parent
                        anchors.margins: 0

                        antialiasing: true
                        legend.visible: false

                        backgroundColor: "transparent"
                        plotAreaColor: "transparent"

                        titleFont.bold: true
                        titleColor: '#ffffff'

                        PieSeries {
                            id: pieSeries
                            size: 0.8

                            function setData(values) {
                                clear()

                                for (let i = 0; i < values.length; i++) {
                                    let slice = append(values[i] + "%", values[i])

                                    slice.color = randomPurpleShade(i)
                                    slice.borderWidth = 2
                                    slice.borderColor = "transparent"

                                    slice.labelVisible = true
                                    slice.labelPosition = 10
                                    slice.labelColor = '#ffffff'
                                    slice.labelFont.pixelSize = 20
                                }
                            }

                            Component.onCompleted: {
                                setData([30, 30, 20, 10, 10])
                            }
                        }

                        Column {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.margins: 10
                            spacing: 8

                            GridLayout {
                                anchors.margins: 10
                                columnSpacing: 8
                                columns: 3

                                Repeater {
                                    model: [
                                        {name: "Анна", value: 30},
                                        {name: "Максим", value: 30},
                                        {name: "Александра", value: 20},
                                        {name: "Дмитрий", value: 10},
                                        {name: "Дмитрий1", value: 10}
                                    ]

                                    delegate: RowLayout {
                                        spacing: 6

                                        Rectangle {
                                            width: 12
                                            height: 12
                                            radius: 6
                                            color: randomPurpleShade(index)
                                            opacity: 0.9
                                        }

                                        Text {
                                            text: modelData.name + " — " + modelData.value + "%"
                                            color: '#ffffff'
                                            font.pixelSize: 10
                                        }
                                    }
                                }
                            }

                            Row {
                                anchors.right: parent.right
                                spacing: 2

                                Text {
                                    text: "Всего записей:"
                                    color: '#ffffff'
                                    font.pixelSize: 16
                                }

                                Text {
                                    text: databaseModel.size()
                                    color: "#8a2be2"
                                    font.pixelSize: 16
                                    font.bold: true
                                }
                            }
                        }
                    }
                    Text {
                        text: "Распределение заказов по мастерам"
                        color: '#ffffff'
                        font.pixelSize: 20
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Substrate {
                    anchors.fill: parent
                    anchors.margins: 3

                    ChartView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        anchors.fill: parent
                        anchors.margins: 0

                        antialiasing: true
                        legend.visible: false

                        backgroundColor: "transparent"
                        plotAreaColor: "transparent"

                        titleFont.bold: true
                        titleColor: '#ffffff'

                        StackedBarSeries {
                            id: mySeries

                            property var modelBarSeries: [
                                { name: "Диагностика", values: [20, 0, 0, 0, 0, 0] },
                                { name: "Замена масла", values: [0, 14, 0, 0, 0, 0] },
                                { name: "Ремонт ходовой", values: [0, 0, 10, 0, 0, 0] },
                                { name: "Шиномонтаж", values: [0, 0, 0, 7, 0, 0] },
                                { name: "Детейлинг", values: [0, 0, 0, 0, 5, 0] },
                                { name: "Кузовной ремонт", values: [0, 0, 0, 0, 0, 3] }
                            ]

                            axisX: BarCategoryAxis {
                                categories: mySeries.modelBarSeries.map(m => m.name)
                                labelsColor: "#8a2be2"
                                labelsAngle: 90
                            }

                            axisY: ValueAxis {
                                labelFormat: "%.0f"
                                labelsColor: "#ffffff"
                            }

                            BarSet {values: mySeries.modelBarSeries[0].values; color: randomPurpleShade(0)}
                            BarSet {values: mySeries.modelBarSeries[1].values; color: randomPurpleShade(1)}
                            BarSet {values: mySeries.modelBarSeries[2].values; color: randomPurpleShade(2)}
                            BarSet {values: mySeries.modelBarSeries[3].values; color: randomPurpleShade(3)}
                            BarSet {values: mySeries.modelBarSeries[4].values; color: randomPurpleShade(4)}
                            BarSet {values: mySeries.modelBarSeries[5].values; color: randomPurpleShade(5)}
                        }
                    }

                    Text {
                        text: "Распределение по услугам"
                        color: '#ffffff'
                        font.pixelSize: 20
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                    }
                }
            }
        }

        Substrate {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: 15
            anchors.margins: 10
        }
    }

    function randomPurpleShade(key) {
        if (!randomPurpleShade._palette) {
            randomPurpleShade._palette = [
                "#8a2be2",
                "#7b1fa2",
                "#9c27b0",
                "#ab47bc",
                "#ba68c8",
                "#5e35b1",
                "#673ab7",
                "#9575cd"
            ]

            randomPurpleShade._map = {}
            randomPurpleShade._next = 0
        }

        let map = randomPurpleShade._map

        if (map[key] !== undefined) {
            return map[key]
        }

        let palette = randomPurpleShade._palette
        let color = palette[randomPurpleShade._next % palette.length]

        randomPurpleShade._map[key] = color
        randomPurpleShade._next++

        return color
    }
}