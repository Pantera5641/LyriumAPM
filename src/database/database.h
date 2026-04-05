#pragma once
#include <vector>
#include <cmath>

#include "record.h"


class Database
{
    private:
    std::vector<Record> dataStore;
    bool isInitialized {};

    Database() = default;

    ~Database() = default;

    void initializeDatabase();

    void saveDatabase() const;

    public:
    Database(const Database&) = delete;

    Database& operator = (const Database&) = delete;

    static Database& getInstance();

    Database* addRecord(
        const QString& clientFullName,
        const QString& phoneNumber,
        const QString& email,
        const QString& carBrandName,
        const QString& carModel,
        const QString& comment,
        const QString& masterFullName,
        const QString& serviceProvided,
        const QString& status);

    [[nodiscard]] Record* getRecordById(int id) const;

    [[nodiscard]] std::vector<Record> getRecordsByPattern(Record pattern) const;
};
