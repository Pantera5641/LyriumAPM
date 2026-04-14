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

QString RecordPageLogic::getPrice(const QString& serviceProvided)
{
    int amount {};
    std::map <QString, int> servicesList {};

    QFile file(QCoreApplication::applicationDirPath() + "/data/servicesList.txt");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream stream(&file);
    while (!stream.atEnd())
    {
        QString line = stream.readLine();
        QStringList tokens = line.split(';');
        servicesList.insert(std::make_pair(tokens.at(1), tokens.at(2).toInt()));
    }

    if (const auto pair = servicesList.find(serviceProvided); pair != servicesList.end())
        amount+=pair->second;

    file.close();

    return QString::number(amount);
}