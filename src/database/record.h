#pragma once
#include <chrono>
#include <string>
#include <vector>


struct Record
{
    private:
    int id;
    std::string clientName;
    std::string phoneNumber;
    std::string email;
    std::string carBrandName;
    std::string carModel;
    std::string comment;
    std::string masterFullName;
    std::string serviceProvided;
    int repairAmount;
    std::chrono::year_month_day visitDate;
    std::string status;

    public:
    Record() = delete;
    
    Record(std::vector<std::string> fields);
};