#pragma once
#include <vector>

#include "record.h"


class Database
{
    private:
    std::vector<Record> dataStore;
    bool isInitialized {};

    void initializeDatabase();

    void saveDatabase() const;

    public:
    Database() = default;
    ~Database() = default;
    Database(const Database&) = delete;
    Database& operator = (const Database&) = delete;

    static Database& getInstance();

    Database* addRecord(Record record);

    [[nodiscard]] Record* getRecordById(int id) const;

    [[nodiscard]] std::vector<Record> getRecordsByPattern(Record pattern) const;
};
