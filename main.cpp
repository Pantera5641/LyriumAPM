#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <qqmlcontext.h>

#include "src/utils/utils.h"
#include "src/database/database.h"
#include "src/logic/recordPage/recordPageLogic.h"
#include "src/logic/models/tagListModel/tagListModel.h"
#include "src/logic/models/databaseModel/databaseModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("resources/logo.png"));

    QQmlApplicationEngine engine;

    RecordPageLogic recordPageLogic;
    engine.rootContext()->setContextProperty("recordPageLogic", &recordPageLogic);

    auto createModel = [&](const QString& type) {
        return new TagListModel(Utils::parseToModel(type), &engine);};
    engine.rootContext()->setContextProperty("carBrandModel", createModel("brandList.txt"));
    engine.rootContext()->setContextProperty("servicesModel", createModel("servicesList.txt"));
    engine.rootContext()->setContextProperty("employeeModel", createModel("employeeList.txt"));
    engine.rootContext()->setContextProperty("sortTagModel", createModel("sortTagList.txt"));
    engine.rootContext()->setContextProperty("statusModel", createModel("statusList.txt"));

    const auto databaseModel =  new DatabaseModel(&engine);
    engine.rootContext()->setContextProperty("databaseModel", databaseModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LyriumAPM", "Main");

    Database& database {Database::getInstance()};
    database.initializeDatabase();
    databaseModel->update();

    return app.exec();
}
