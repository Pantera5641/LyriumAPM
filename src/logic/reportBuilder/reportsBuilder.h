#pragma once
#include <QDir>
#include <QString>
#include <QObject>
#include <QTextDocument>
#include <QWebEnginePage>
#include <QDesktopServices>

#include "../../database/database.h"


class ReportsBuilder : public QObject
{
    private:
    QWebEnginePage *page {nullptr};

    static QString loadHtml(const QString &path);

    static QString getPdfPath(const QString &fileName);

    void createReport(const QString &html, const QString &pdfFilename, const QUrl &baseUrl);

    Q_OBJECT
    public:
    explicit ReportsBuilder(QObject *parent = nullptr);

    Q_INVOKABLE
    static void openReportsFolder();

    Q_INVOKABLE
    void createRecordReport(int id);
};