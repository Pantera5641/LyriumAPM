#include "reportsBuilder.h"

QString ReportsBuilder::loadHtml(const QString& path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) return QString();

    QTextStream in(&file);
    in.setCodec("UTF-8");
    return in.readAll();
}

QString ReportsBuilder::getPdfPath(const QString &fileName)
{
    const QString pdfPath {QStringLiteral("%1/reports/%2%3.pdf")
        .arg(QCoreApplication::applicationDirPath())
        .arg(fileName)
        .arg(QDateTime::currentDateTime().toString("_yyyy-MM-dd_HHmmsszzz"))};

    return pdfPath;
}

void ReportsBuilder::createReport(const QString &html, const QString &pdfFilename, const QUrl &baseUrl)
{
    const QDir dir {};
    (void)dir.mkdir("reports");

    page = new QWebEnginePage(this);

    connect(page, &QWebEnginePage::loadFinished, this, [this, pdfFilename] {
        page->printToPdf(pdfFilename);});

    page->setHtml(html, baseUrl);
}

ReportsBuilder::ReportsBuilder(QObject *parent) : QObject(parent){}

void ReportsBuilder::openReportsFolder()
{
    const QDir dir {};
    (void)dir.mkdir("reports");

    QDesktopServices::openUrl(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/reports"));
}

void ReportsBuilder::createRecordReport(const int id)
{
    const Database &database = Database::getInstance();
    const auto record = database.getRecordById(id).toSimpleRecord();

    QString html = loadHtml(":/resources/reports/record_report.html");

    html.replace("{id}", record.id);
    html.replace("{status_mark}", Utils::find("statusList.txt", QStringLiteral("%1").arg(record.status)).at(2));
    html.replace("{status}", record.status);
    html.replace("{client_full_name}", record.clientFullName);
    html.replace("{phone_number}", record.phoneNumber);
    html.replace("{email}", record.email);
    html.replace("{car_brand_name}", record.carBrand);
    html.replace("{car_model}", record.carModel);
    html.replace("{comment}", record.comment);
    html.replace("{master_full_name}", record.masterFullName);
    html.replace("{service_provided}", record.serviceProvided);
    html.replace("{visit_date}", record.date);

    const QString timeNow {QStringLiteral("%1 в %2")
        .arg(QDateTime::currentDateTime().toString("dd.MM.yyyy"))
        .arg(QDateTime::currentDateTime().toString("HH:mm"))};
    html.replace("{creation_date}", timeNow);

    createReport(html, getPdfPath(QStringLiteral("Отчет_О_Записи_№%1").arg(record.id)),
        QUrl("qrc:/resources/reports/record_report.html"));
}
