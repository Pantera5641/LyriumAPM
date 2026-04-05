#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <qqmlcontext.h>

#include "src/logic/recordPage/recordPageLogic.h"
#include "src/database/database.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("resources/logo.png"));

    QQmlApplicationEngine engine;

    RecordPageLogic recordPageLogic;
    engine.rootContext()->setContextProperty("recordPageLogic", &recordPageLogic);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LyriumAPM", "Main");

    Database& database {Database::getInstance()};
    database.initializeDatabase();

    return app.exec();
}
