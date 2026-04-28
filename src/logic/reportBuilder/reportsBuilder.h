#pragma once
#include <QDir>
#include <QString>
#include <QObject>
#include <QTextDocument>
#include <QWebEnginePage>
#include <QDesktopServices>
#include <QPageLayout>
#include <QQueue>

#include "../../database/database.h"


struct ReportTask {
    QString html {};
    QUrl baseUrl {};
    QUrl filename {};
};

class ReportsBuilder : public QObject
{
    private:
    QWebEnginePage *page {nullptr};
    QQueue<ReportTask> tasks {};
    bool busy {false};

    static QString loadHtml(const QString &path);

    static QString fillHtmlPlaceholders(const QString& baseHtml, const SimpleRecord& record);

    static QString getPdfPath(const QString &fileName);

    void enqueueTask(const ReportTask &task);

    void processNextTask();

    Q_OBJECT
    public:
    explicit ReportsBuilder(QObject *parent = nullptr);

    Q_INVOKABLE
    static void openReportsFolder();

    Q_INVOKABLE
    void createFullReport();

    Q_INVOKABLE
    void createRecordReport(int id);
};