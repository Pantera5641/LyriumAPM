#pragma once
#include <chrono>
#include <string>
#include <utility>
#include <fstream>
#include <map>

#include "src/utils/utils.h"


struct Record
{
    private:
    int id {};
    std::string clientName {};
    std::string phoneNumber {};
    std::string email {};
    std::string carBrandName {};
    std::string carModel {};
    std::string comment {};
    std::string masterFullName {};
    std::string serviceProvided {};
    int repairAmount {};
    std::chrono::year_month_day visitDate {};
    std::string status {};

    void updateRepairAmount(const std::string& serviceProvided);

    public:
    Record() = delete;

    Record(
    int id,
    const std::string& clientName,
    const std::string& phoneNumber,
    const std::string& email,
    const std::string& carBrandName,
    const std::string& carModel,
    const std::string& comment,
    const std::string& masterFullName,
    const std::string& serviceProvided,
    int repairAmount,
    const std::chrono::year_month_day& visitDate,
    const std::string& status);

    Record(
        int id,
        const std::string& clientName,
        const std::string& phoneNumber,
        const std::string& email,
        const std::string& carBrandName,
        const std::string& carModel,
        const std::string& comment,
        const std::string& masterFullName,
        const std::string& serviceProvided,
        const std::chrono::year_month_day& visitDate,
        const std::string& status);

    [[nodiscard]] int getId() const;

    [[nodiscard]] std::string getClientName() const;

    [[nodiscard]] std::string getPhoneNumber() const;

    [[nodiscard]] std::string getEmail() const;

    [[nodiscard]] std::string getCarBrandName() const;

    [[nodiscard]] std::string getCarModel() const;

    [[nodiscard]] std::string getComment() const;

    [[nodiscard]] std::string getMasterFullName() const;

    [[nodiscard]] std::string getServiceProvided() const;

    [[nodiscard]] int getRepairAmount() const;

    [[nodiscard]] std::chrono::year_month_day getVisitDate() const;

    [[nodiscard]] std::string getStatus() const;

    Record* setStatus(const std::string& status);

    Record* addService(const std::string& serviceProvided);

    [[nodiscard]] std::string toString() const;
};