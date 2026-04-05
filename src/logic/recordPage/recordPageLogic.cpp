#include "recordPageLogic.h"


void RecordPageLogic::addRecordInDataBase(
    const QString &clientFullName,
    const QString &phoneNumber,
    const QString &email,
    const QString &carBrandName,
    const QString &carModel,
    const QString &comment,
    const QString &masterFullName,
    const QString &serviceProvided,
    const QString &status)
{
    Database& database {Database::getInstance()};
    database.addRecord(
        clientFullName,
        phoneNumber,
        email,
        carBrandName,
        carModel,
        comment,
        masterFullName,
        serviceProvided,
        status);
}
