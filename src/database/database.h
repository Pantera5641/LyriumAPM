#pragma once
#include <vector>

#include "record.h"


class Database
{
    private:
    std::vector<Record> dataStore;

    public:
    Database() = default;
    ~Database() = default;
    Database(const Database&) = delete;
    Database& operator = (const Database&) = delete;

    static Database& getInstance();


};
