#include "database.h"


void Database::initializeDatabase()
{
    QFile file("data/dataBase.txt");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream stream(&file);
    while (!stream.atEnd())
    {
        QString line = stream.readLine();
        QStringList tokens {line.split(';')};
        QStringList dataTokens {tokens.at(10).split('.')};
        std::chrono::year_month_day data
        {
            std::chrono::year(dataTokens.at(0).toInt()),
            std::chrono::month(dataTokens.at(1).toInt()),
            std::chrono::day(dataTokens.at(2).toUInt())
        };

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
    this->isInitialized = true;
}

void Database::saveDatabase() const
{
    QFile file("data/dataBase.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream stream(&file);
    for (auto item : dataStore)
        stream << item.toString() << "\n";
}

Database& Database::getInstance()
{
    static Database instance;
    if (!instance.isInitialized) instance.initializeDatabase();
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
        std::chrono::floor<std::chrono::days>(std::chrono::system_clock::now()),
        status
        );
    dataStore.push_back(record);
    saveDatabase();
    return this;
}

Record* Database::getRecordById(const int id) const
{
    for (auto item : dataStore)
    {
        if (item.getId() == id)
            return &item;
    }

    return nullptr;
}

std::vector<Record> Database::getRecordsByPattern(Record pattern) const
{
    throw std::runtime_error("Not implemented");
    std::vector<Record> records;
    for (auto item : dataStore)
    {
        bool flag {true};
        flag *= item.getClientFullName().contains(pattern.getClientFullName()) || pattern.getClientFullName() == QString();
        flag *= item.getPhoneNumber().contains(pattern.getPhoneNumber()) || pattern.getPhoneNumber() == QString();
        flag *= item.getEmail().contains(pattern.getEmail()) || pattern.getEmail() == QString();
        flag *= item.getCarBrandName().contains(pattern.getCarBrandName()) || pattern.getCarBrandName() == QString();
        flag *= item.getCarModel().contains(pattern.getCarModel()) || pattern.getCarModel() == QString();
        flag *= item.getMasterFullName().contains(pattern.getMasterFullName()) || pattern.getMasterFullName() == QString();
        //i too lazy to do it
    }
}
