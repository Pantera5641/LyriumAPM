import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Row{
        Button {
            text: "ReportsFolder()"
            onClicked: reportsBuilder.openReportsFolder()
        }

        Button {
            text: "FullReport()"
            onClicked: reportsBuilder.createFullReport()
        }

        Button {
            text: "RecordReport(11)"
            onClicked: reportsBuilder.createRecordReport(11)
        }
    }
}