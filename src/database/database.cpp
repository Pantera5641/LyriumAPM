#include "database.h"

#include <iostream>
#include <qcoreapplication.h>
#include <QDebug>
#include <algorithm>


void Database::initializeDatabase()
{
    if (this->isInitialized)
    {
        throw std::runtime_error("Database is already initialized");
    }

    QFile file(QCoreApplication::applicationDirPath() + "/data/dataBase.txt");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream stream(&file);
    stream.setCodec("UTF-8");
    while (!stream.atEnd())
    {
        QString line = stream.readLine();
        QStringList tokens {line.split(';')};
        QStringList dataTokens {tokens.at(10).split('.')};
        const QDate data(dataTokens.at(0).toInt(), dataTokens.at(1).toInt(), dataTokens.at(2).toUInt());

        Record record(
        tokens.at(0).toInt(),
        tokens.at(1),
        tokens.at(2),
        tokens.at(3),
        tokens.at(4),
        tokens.at(5),
        tokens.at(6),
        tokens.at(7),
        tokens.at(8),
        tokens.at(9).toInt(),
        data,
        tokens.at(11));

        dataStore.push_back(record);
    }
    file.close();

    this->isInitialized = true;
}

void Database::saveDatabase() const
{
    QFile file(QCoreApplication::applicationDirPath() + "/data/dataBase.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream stream(&file);
    stream.setCodec("UTF-8");
    for (auto item : dataStore)
        stream << item.toString() << "\n";
    file.close();
}

QList<Record> Database::getRecords(const QString& sortTag, const QString &search)
{
    QList<Record> newRecords {};

    for (auto item : dataStore)
        if (item.toSimpleRecord().toString().contains(search, Qt::CaseInsensitive)) newRecords.push_back(item);

    if (sortTag != "none")
    {
        std::sort(newRecords.begin(), newRecords.end(),
            [sortTag](const Record& a, const Record& b)
        {
            const auto& strA = a.getFieldByTag(sortTag);
            const auto& strB = b.getFieldByTag(sortTag);

            bool okA, okB;
            const int valA = strA.toInt(&okA);
            const int valB = strB.toInt(&okB);

            if (okA && okB) return valA < valB;

            return strA < strB;
        });
    }

    return newRecords;
}


Database& Database::getInstance()
{
    static Database instance;
    return instance;
}

Database* Database::addRecord(
        const QString& clientFullName,
        const QString& phoneNumber,
        const QString& email,
        const QString& carBrandName,
        const QString& carModel,
        const QString& comment,
        const QString& masterFullName,
        const QString& serviceProvided,
        const QString& status)
{
    const int id {dataStore.size() == 0 ? 1 : dataStore.at(dataStore.size() - 1).getId() + 1};
    const Record record(
        id,
        clientFullName,
        phoneNumber,
        email,
        carBrandName,
        carModel,
        comment,
        masterFullName,
        serviceProvided,
        QDate::currentDate(),
        status);
    dataStore.push_back(record);
    saveDatabase();
    return this;
}

Record Database::getRecordById(const int id) const
{
    for (auto item : dataStore)
    {
        if (item.getId() == id)
            return item;
    }

    throw std::out_of_range("Record does not exist");
}

void Database::setStatus(const int id, const QString &status)
{
    dataStore[id - 1].setStatus(status);
    saveDatabase();
}

void Database::setValueByIdTag(const int id, const QString &tag, const QString &status)
{
    dataStore[id - 1].setValueByTag(tag, status);
    saveDatabase();
}
