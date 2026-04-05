#include "database.h"

void Database::initializeDatabase()
{
    std::ifstream file("data/dataBase.txt");
    std::string line;
    while (std::getline(file, line))
    {
        std::vector tokens {Utils::split(line, ';')};

        std::vector dataTokens {Utils::split(tokens.at(10), '.')};
        std::chrono::year_month_day data
        {
            std::chrono::year(std::stoi(dataTokens.at(0))),
            std::chrono::month(std::stoi(dataTokens.at(1))),
            std::chrono::day(std::stoi(dataTokens.at(2)))
        };

        Record record(
        std::stoi(tokens.at(0)),
        tokens.at(1),
        tokens.at(2),
        tokens.at(3),
        tokens.at(4),
        tokens.at(5),
        tokens.at(6),
        tokens.at(7),
        tokens.at(8),
        std::stoi(tokens.at(9)),
        data,
        tokens.at(11));

        dataStore.push_back(record);
    }
    this->isInitialized = true;
}

void Database::saveDatabase() const
{
    std::ofstream file("data/dataBase.txt", std::ios::trunc);
    for (auto item : dataStore)
        file << item.toString();
}

Database& Database::getInstance()
{
    static Database instance;
    if (!instance.isInitialized) instance.initializeDatabase();
    return instance;
}

Database* Database::addRecord(Record record)
{
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
        flag *= item.getClientName().contains(pattern.getClientName()) || pattern.getClientName() == std::string();
        flag *= item.getPhoneNumber().contains(pattern.getPhoneNumber()) || pattern.getPhoneNumber() == std::string();
        flag *= item.getEmail().contains(pattern.getEmail()) || pattern.getEmail() == std::string();
        flag *= item.getCarBrandName().contains(pattern.getCarBrandName()) || pattern.getCarBrandName() == std::string();
        flag *= item.getCarModel().contains(pattern.getCarModel()) || pattern.getCarModel() == std::string();
        flag *= item.getMasterFullName().contains(pattern.getMasterFullName()) || pattern.getMasterFullName() == std::string();
        //i too lazy to do it
    }
}
