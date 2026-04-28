#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include <QWebEngineSettings>

#include "src/utils/utils.h"
#include "src/database/database.h"
#include "src/logic/recordPage/recordPageLogic.h"
#include "src/logic/models/tagListModel/tagListModel.h"
#include "src/logic/models/databaseModel/databaseModel.h"
#include "src/logic/reportBuilder/reportsBuilder.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    QApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
    qputenv("QT_SCALE_FACTOR", "0.8");
    const QApplication app(argc, argv);

    app.setWindowIcon(QIcon(QCoreApplication::applicationDirPath() + "/logo.png"));

    QQmlApplicationEngine engine;

    RecordPageLogic recordPageLogic;
    engine.rootContext()->setContextProperty("recordPageLogic", &recordPageLogic);

    auto createModel = [&](const QString& type) {
        return new TagListModel(Utils::parseToModel(type), &engine);
    };

    engine.rootContext()->setContextProperty("carBrandModel", createModel("brandList.txt"));
    engine.rootContext()->setContextProperty("servicesModel", createModel("servicesList.txt"));
    engine.rootContext()->setContextProperty("employeeModel", createModel("employeeList.txt"));
    engine.rootContext()->setContextProperty("sortTagModel", createModel("sortTagList.txt"));
    engine.rootContext()->setContextProperty("statusModel", createModel("statusList.txt"));

    const auto databaseModel = new DatabaseModel(&engine);
    engine.rootContext()->setContextProperty("databaseModel", databaseModel);

    const auto reportsBuilder = new ReportsBuilder(&engine);
    engine.rootContext()->setContextProperty("reportsBuilder", reportsBuilder);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [&](const QObject *obj, const QUrl &) {
            if (!obj)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));

    QWebEngineSettings::globalSettings()->setAttribute(
    QWebEngineSettings::PrintElementBackgrounds, true);

    QWebEngineSettings::globalSettings()->setAttribute(
    QWebEngineSettings::JavascriptEnabled, false);

    Database& database = Database::getInstance();
    database.initializeDatabase();
    databaseModel->update();

    return app.exec();
}