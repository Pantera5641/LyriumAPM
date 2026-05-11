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
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 15
            spacing: 15

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
                        titleColor: Colors.text

                        PieSeries {
                            id: pieSeries
                            size: 0.7

                            property var modelPieSeries: databaseModel.pieSeriesModel

                            function setData(values) {
                                pieSeries.clear()
                                for (let i = 0; i < values.length; i++) {
                                    let slice = append(Number(values[i]).toFixed(1) + "%", values[i])
                                    slice.color = randomPurpleShade(i)
                                    slice.borderWidth = 2
                                    slice.borderColor = "transparent"
                                    slice.labelVisible = true
                                    slice.labelPosition = 10
                                    slice.labelColor = Colors.text
                                    slice.labelFont.pixelSize = 20
                                }
                            }

                            Component.onCompleted: {
                                setData(pieSeries.modelPieSeries.map(v => v.value))
                            }

                            Connections {
                                target: databaseModel

                                function onPieSeriesModelChanged() {
                                    pieSeries.setData(pieSeries.modelPieSeries.map(v => v.value))
                                }
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
                                    model: databaseModel.pieSeriesModel

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
                                            text: modelData.name + " — " + Number(modelData.value).toFixed(1) + "%"
                                            color: Colors.text
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
                                    color: Colors.text
                                    font.pixelSize: 16
                                }
                                Text {
                                    text: databaseModel.size
                                    color: Colors.main
                                    font.pixelSize: 16
                                    font.bold: true
                                }
                            }
                        }
                    }

                    Text {
                        text: "Распределение заказов по мастерам"
                        color: Colors.text
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
                        titleColor: Colors.text

                        StackedBarSeries {
                            id: mySeries
                            property var modelBarSeries: databaseModel.barSeriesModel

                            axisX: BarCategoryAxis {
                                categories: mySeries.modelBarSeries.map(m => m.name)
                                labelsColor: Colors.main
                                labelsAngle: 90
                            }

                            axisY: ValueAxis {
                                id: aY
                                labelFormat: "%.0f"
                                labelsColor: Colors.text
                            }

                            BarSet {id: s1; values: mySeries.toNumArr(mySeries.modelBarSeries[0].values); color: randomPurpleShade(0)}
                            BarSet {id: s2; values: mySeries.toNumArr(mySeries.modelBarSeries[1].values); color: randomPurpleShade(1)}
                            BarSet {id: s3; values: mySeries.toNumArr(mySeries.modelBarSeries[2].values); color: randomPurpleShade(2)}
                            BarSet {id: s4; values: mySeries.toNumArr(mySeries.modelBarSeries[3].values); color: randomPurpleShade(3)}
                            BarSet {id: s5; values: mySeries.toNumArr(mySeries.modelBarSeries[4].values); color: randomPurpleShade(4)}
                            BarSet {id: s6; values: mySeries.toNumArr(mySeries.modelBarSeries[5].values); color: randomPurpleShade(5)}

                            Connections {
                                target: databaseModel

                                function onBarSeriesModelChanged() {
                                    var sets = [s1, s2, s3, s4, s5, s6]

                                    for (let i = 0; i < sets.length; i++) {
                                        sets[i].values = mySeries.toNumArr(mySeries.modelBarSeries[i].values)
                                    }

                                    aY.max = mySeries.modelBarSeries[0].values[0];
                                }
                            }

                            function toNumArr(v) {
                                let arr = []

                                for (let i = 0; i < v.length; i++) {
                                    arr.push(Number(v[i]))
                                }

                                return arr
                            }
                        }
                    }

                    Text {
                        text: "Распределение по услугам"
                        color: Colors.text
                        font.pixelSize: 20
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                    }
                }
            }
        }

        Rectangle {
            id: statsBar
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            Layout.bottomMargin: 15

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
                    value:  databaseModel.revenue + " ₽"
                    iconSource: "qrc:/resources/state/money.png"
                    iconColor: "#d05ce3"
                    isLargeValue: true
                }
            }
        }
    }

    component Divider: Rectangle {
        width: 2
        height: parent.height * 0.6
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
            anchors.topMargin: -35
            spacing: 0

            Image {
                Layout.preferredWidth: 45
                Layout.preferredHeight: 45
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                smooth: true
                mipmap: true

                source: iconSource
                fillMode: Image.PreserveAspectFit
                opacity: 1

                Component {
                    id: fallbackCircle
                    Rectangle {
                        width: 32; height: 32; radius: 16
                        color: "transparent";
                        border.color: iconColor;
                        border.width: 2;
                        opacity: 0.5
                    }
                }
            }

            Text {
                text: title
                color: "#aaaaaa"
                font.pixelSize: 10
                font.bold: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                maximumLineCount: 1
                elide: Text.ElideRight
                Layout.bottomMargin: -2
            }

            Text {
                text: value
                color: isLargeValue ? Colors.additional : Colors.text
                font.pixelSize: isLargeValue ? 16 : 20
                font.bold: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                horizontalAlignment: Text.AlignHCenter
                Layout.bottomMargin: -5
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 0.8
            onExited: parent.opacity = 1.0
            Behavior on opacity { NumberAnimation { duration: 150 } }
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