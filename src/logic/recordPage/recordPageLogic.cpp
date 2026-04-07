#include "recordPageLogic.h"


void RecordPageLogic::addRecordInDataBase(
    const QString &clientFullName,
    const QString &phoneNumber,
    const QString &email,
    const QString &carBrandName,
    const QString &carModel,
    const QString &comment,
    const QString &masterFullName,
    const QString &serviceProvided)
{
    //Сделать отдельный класс для валидации
    QString safeComment {comment};
    safeComment.replace(";", ",").replace("\n", "\\n");

    Database& database {Database::getInstance()};
    database.addRecord(
        clientFullName,
        phoneNumber,
        email,
        carBrandName,
        carModel,
        safeComment,
        masterFullName,
        serviceProvided,
        "accepted");
}
