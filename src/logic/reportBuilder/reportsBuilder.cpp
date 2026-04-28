#include "reportsBuilder.h"


QString ReportsBuilder::loadHtml(const QString& path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) return QString();

    QTextStream in(&file);
    in.setCodec("UTF-8");
    return in.readAll();
}

QString ReportsBuilder::fillHtmlPlaceholders(const QString& baseHtml, const SimpleRecord& record)
{
    QString html {baseHtml};

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

    return html;
}

QString ReportsBuilder::getPdfPath(const QString &fileName)
{
    static int counter {};

    const QString pdfPath {QStringLiteral("%1/reports/%2%3%4.pdf")
        .arg(QCoreApplication::applicationDirPath())
        .arg(fileName)
        .arg(QDateTime::currentDateTime().toString("_yyyy-MM-dd_HHmmsszzz"))
        .arg(counter++)};
    return pdfPath;
}

void ReportsBuilder::enqueueTask(const ReportTask& task)
{
    tasks.enqueue(task);

    if (!busy) processNextTask();
}

void ReportsBuilder::processNextTask()
{
    const QDir dir {};
    (void)dir.mkdir("reports");

    if (busy || tasks.empty()) return;

    busy = true;
    const auto [html, baseUrl, filename] = tasks.dequeue();

    page->setProperty("filename", filename);
    page->setHtml(html, baseUrl);
}

ReportsBuilder::ReportsBuilder(QObject *parent) : QObject(parent)
{
    page = new QWebEnginePage(this);

    connect(page, &QWebEnginePage::loadFinished, this, [this](const bool success) {
        if (!success)
        {
            busy = false;
            processNextTask();
            return;
        }

        QPageLayout layout {};
        layout.setPageSize(QPageSize(QPageSize::A4));
        layout.setOrientation(QPageLayout::Portrait);
        layout.setMode(QPageLayout::FullPageMode);
        layout.setMargins(QMarginsF(0, 0, 0, 0));

        const QString filename {page->property("filename").toString()};
        page->printToPdf(filename, layout);
    });

    connect(page, &QWebEnginePage::pdfPrintingFinished, this, [this](const QString &path, bool success) {
        busy = false;
        processNextTask();
    });

    page->setBackgroundColor(QColor("#121212"));
    page->setHtml("<html></html>");
}

void ReportsBuilder::openReportsFolder()
{
    const QDir dir {};
    (void)dir.mkdir("reports");

    QDesktopServices::openUrl(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/reports"));
}

void ReportsBuilder::createFullReport()
{
    const Database &database = Database::getInstance();

    QString html {loadHtml(":/resources/reports/full_report.html")};
    QString cards {};

    const QString timeNow {QStringLiteral("%1 в %2")
        .arg(QDateTime::currentDateTime().toString("dd.MM.yyyy"))
        .arg(QDateTime::currentDateTime().toString("HH:mm"))};
    html.replace("{creation_date}", timeNow);

    const QString cardTemplate {loadHtml(":/resources/reports/full_report_card.html")};
    for (int i = 0; i < database.getRecordCount(); i++)
    {
        const auto record = database.getRecordById(i + 1).toSimpleRecord();
        cards+= fillHtmlPlaceholders(cardTemplate, record) + "\n";
    }
    html.replace("{cards}", cards);

    const ReportTask task {html,
        QUrl("qrc:/resources/reports/full_report.html"),
        getPdfPath(QStringLiteral("Полный_отчет"))};

    enqueueTask(task);
}

void ReportsBuilder::createRecordReport(const int id)
{
    const Database &database = Database::getInstance();
    const auto record = database.getRecordById(id).toSimpleRecord();
    QString html {fillHtmlPlaceholders(loadHtml(":/resources/reports/record_report.html"), record)};

    const QString timeNow {QStringLiteral("%1 в %2")
        .arg(QDateTime::currentDateTime().toString("dd.MM.yyyy"))
        .arg(QDateTime::currentDateTime().toString("HH:mm"))};
    html.replace("{creation_date}", timeNow);

    const ReportTask task {html,
        QUrl("qrc:/resources/reports/record_report.html"),
        getPdfPath(QStringLiteral("Отчет_О_Записи_№%1").arg(record.id))};

    enqueueTask(task);
}