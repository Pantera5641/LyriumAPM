#pragma once
#include <vector>
#include <cmath>

#include "record.h"


class Database
{
    private:
    QList<Record> dataStore;
    bool isInitialized {};

    Database() = default;

    ~Database() = default;

    void saveDatabase() const;

    public:
    Database(const Database&) = delete;

    Database& operator = (const Database&) = delete;

    QList<Record> getRecords(const QString & chars, const QString & string);

    static Database& getInstance();

    void initializeDatabase();

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

    void setStatus(int id, const QString& status);
};
