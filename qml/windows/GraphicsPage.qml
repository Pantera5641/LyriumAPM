import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.15
import styles 1.0
import "../components"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Substrate {
                    anchors.fill: parent
                    anchors.margins: 4

                    ChartView {
                        id: pieChart
                        anchors.fill: parent
                        anchors.margins: 8

                        antialiasing: true
                        legend.visible: false
                        backgroundColor: "transparent"
                        plotAreaColor: "transparent"

                        plotArea: Qt.rect(
                            width * 0.015,
                            height * 0.04,
                            width * 0.78,
                            height * 0.74
                        )

                        PieSeries {
                            id: pieSeries
                            holeSize: 0.59
                            size: 0.80

                            property var modelData: databaseModel.pieSeriesModel

                            function updateData() {
                                pieSeries.clear()
                                for (var i = 0; i < modelData.length; ++i) {
                                    var slice = append(
                                        Number(modelData[i].value).toFixed(1) + "%",
                                        modelData[i].value
                                    )
                                    slice.color = randomPurpleShade(i)
                                    slice.borderWidth = 4
                                    slice.borderColor = "#1a1a2e"
                                    slice.labelVisible = false
                                }
                            }

                            Component.onCompleted: updateData()

                            Connections {
                                target: databaseModel
                                function onPieSeriesModelChanged() {
                                    pieSeries.updateData()
                                }
                            }
                        }
                    }

                    Column {
                        anchors.centerIn: pieChart
                        spacing: 4
                        z: 5

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: databaseModel.size
                            color: Colors.text
                            font.pixelSize: 52
                            font.bold: true
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "всего заказов"
                            color: Colors.invertedbackgroundShade
                            font.pixelSize: 20
                        }
                    }

                    Text {
                        text: "Распределение заказов по мастерам"
                        color: Colors.text
                        font.pixelSize: 20
                        font.bold: true
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 14
                    }

                    GridLayout {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 22
                        columns: 2
                        columnSpacing: 18
                        rowSpacing: 8

                        Repeater {
                            model: databaseModel.pieSeriesModel
                            delegate: RowLayout {
                                spacing: 8
                                Rectangle {
                                    width: 14
                                    height: 14
                                    radius: 7
                                    color: randomPurpleShade(index)
                                }
                                Text {
                                    text: modelData.name + " — " + Number(modelData.value).toFixed(1) + "%"
                                    color: Colors.text
                                    font.pixelSize: 14
                                }
                            }
                        }
                    }
                }
            }


            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Substrate {
                    anchors.fill: parent
                    anchors.margins: 4

                    ChartView {
                        id: barChart
                        anchors.fill: parent
                        anchors.margins: 12

                        antialiasing: true
                        legend.visible: false
                        backgroundColor: "transparent"
                        plotAreaColor: "transparent"

                        plotArea: Qt.rect(
                            width * 0.06,
                            height * 0.05,
                            width * 0.7,
                            height * 0.52
                        )

                        StackedBarSeries {
                            id: stackedSeries

                            axisX: BarCategoryAxis {
                                id: axisX
                                labelsColor: Colors.text
                                labelsAngle: -75     // сильнее наклон
                                gridVisible: false
                                labelsFont.pixelSize: 16
                            }

                            axisY: ValueAxis {
                                id: axisY
                                labelFormat: "%.0f"
                                labelsColor: Colors.text
                                labelsFont.pixelSize: 15
                                min: 0
                            }

                            property var modelData: databaseModel.barSeriesModel

                            function updateSeries() {
                                while (stackedSeries.count > 0)
                                    stackedSeries.remove(stackedSeries.at(0))

                                if (modelData.length === 0) return

                                var categories = []
                                for (var i = 0; i < modelData.length; ++i) {
                                    categories.push(modelData[i].name || "Услуга " + (i+1))
                                }
                                axisX.categories = categories

                                for (var i = 0; i < modelData.length; ++i) {
                                    var barSet = stackedSeries.append(modelData[i].name || "Серия " + i, [])
                                    barSet.color = randomPurpleShade(i)

                                    var numValues = []
                                    for (var j = 0; j < modelData[i].values.length; ++j) {
                                        numValues.push(Number(modelData[i].values[j] || 0))
                                    }
                                    barSet.values = numValues
                                }

                                var maxVal = 0
                                for (var m = 0; m < modelData.length; ++m) {
                                    for (var n = 0; n < modelData[m].values.length; ++n) {
                                        var v = Number(modelData[m].values[n] || 0)
                                        if (v > maxVal) maxVal = v
                                    }
                                }
                                axisY.max = Math.max(maxVal * 1.15, 10)
                            }

                            Component.onCompleted: updateSeries()

                            Connections {
                                target: databaseModel
                                function onBarSeriesModelChanged() {
                                    stackedSeries.updateSeries()
                                }
                            }
                        }
                    }

                    Text {
                        text: "Распределение по услугам"
                        color: Colors.text
                        font.pixelSize: 20
                        font.bold: true
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 14
                    }
                }
            }
        }

        // ==================== НИЖНЯЯ СТАТИСТИКА ====================
        Rectangle {
            id: statsBar
            Layout.fillWidth: true
            Layout.preferredHeight: 118
            color: Colors.substrate
            radius: 14
            border.color: Colors.main
            border.width: 2

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 0

                StatItem {
                    Layout.fillWidth: true
                    title: "Всего заказов"
                    value: databaseModel.size
                    iconSource: "qrc:/resources/state/all.png"
                    iconColor: Colors.main
                }

                StatItem {
                    id: completedId
                    Layout.fillWidth: true
                    title: "Выполнено"
                    value: databaseModel.getNumOfStatuses("completed")
                    iconSource: "qrc:/resources/state/ready.png"
                    iconColor: "#00ff9d"

                    Connections {
                        target: databaseModel
                        function onUpdated() {
                            completedId.value = databaseModel.getNumOfStatuses("completed")
                        }
                    }
                }

                Divider {}

                StatItem {
                    id: inProgressId
                    Layout.fillWidth: true
                    title: "В процессе"
                    value: databaseModel.getNumOfStatuses("in_progress")
                    iconSource: "qrc:/resources/state/in_progress.png"
                    iconColor: "#ffa500"

                    Connections {
                        target: databaseModel
                        function onUpdated() {
                            inProgressId.value = databaseModel.getNumOfStatuses("in_progress")
                        }
                    }
                }

                Divider {}

                StatItem {
                    id: canceledId
                    Layout.fillWidth: true
                    title: "Отменено"
                    value: databaseModel.getNumOfStatuses("canceled")
                    iconSource: "qrc:/resources/state/cancel.png"
                    iconColor: "#ff6b6b"

                    Connections {
                        target: databaseModel
                        function onUpdated() {
                            canceledId.value = databaseModel.getNumOfStatuses("canceled")
                        }
                    }
                }

                Divider {}

                StatItem {
                    Layout.fillWidth: true
                    title: "Выручка"
                    value: databaseModel.revenue + " ₽"
                    iconSource: "qrc:/resources/state/money.png"
                    iconColor: "#d05ce3"
                    isLargeValue: true
                }
            }
        }
    }

    component Divider: Rectangle {
        width: 2
        height: parent.height * 0.65
        color: Colors.backgroundShade
        Layout.alignment: Qt.AlignVCenter
    }

    component StatItem: Item {
        property string title: ""
        property string value: ""
        property string iconSource: ""
        property string iconColor: Colors.main
        property bool isLargeValue: false

        ColumnLayout {
            anchors.fill: parent
            anchors.topMargin: -42
            spacing: 0

            Image {
                Layout.preferredWidth: 46
                Layout.preferredHeight: 46
                Layout.alignment: Qt.AlignHCenter
                source: iconSource
                fillMode: Image.PreserveAspectFit
                mipmap: true
            }

            Text {
                text: title
                color: "#aaaaaa"
                font.pixelSize: 11
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.topMargin: 4
            }

            Text {
                text: value
                color: isLargeValue ? Colors.additional : Colors.text
                font.pixelSize: isLargeValue ? 17 : 22
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    function randomPurpleShade(key) {
        if (!randomPurpleShade._palette) {
            randomPurpleShade._palette = [
                "#8a2be2", "#7b1fa2", "#9c27b0", "#ab47bc",
                "#ba68c8", "#5e35b1", "#673ab7", "#9575cd"
            ]
            randomPurpleShade._cache = {}
        }
        if (randomPurpleShade._cache[key] !== undefined)
            return randomPurpleShade._cache[key]

        var color = randomPurpleShade._palette[key % randomPurpleShade._palette.length]
        randomPurpleShade._cache[key] = color
        return color
    }
}