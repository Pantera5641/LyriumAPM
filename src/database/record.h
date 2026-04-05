#pragma once
#include <QFile>
#include <QTextStream>
#include <qcoreapplication.h>
#include <chrono>
#include <utility>
#include <fstream>
#include <map>


struct Record
{
    private:
    int id {};
    QString clientFullName {};
    QString phoneNumber {};
    QString email {};
    QString carBrandName {};
    QString carModel {};
    QString comment {};
    QString masterFullName {};
    QString serviceProvided {};
    int repairAmount {};
    std::chrono::year_month_day visitDate {};
    QString status {};

    void updateRepairAmount(const QString& serviceProvided);

    public:
    Record() = delete;

    Record(
    int id,
    const QString& clientFullName,
    const QString& phoneNumber,
    const QString& email,
    const QString& carBrandName,
    const QString& carModel,
    const QString& comment,
    const QString& masterFullName,
    const QString& serviceProvided,
    int repairAmount,
    const std::chrono::year_month_day& visitDate,
    const QString& status);

    Record(
        int id,
        const QString& clientFullName,
        const QString& phoneNumber,
        const QString& email,
        const QString& carBrandName,
        const QString& carModel,
        const QString& comment,
        const QString& masterFullName,
        const QString& serviceProvided,
        const std::chrono::year_month_day& visitDate);

    [[nodiscard]]
    int getId() const;

    [[nodiscard]]
    QString getClientFullName() const;

    [[nodiscard]]
    QString getPhoneNumber() const;

    [[nodiscard]]
    QString getEmail() const;

    [[nodiscard]]
    QString getCarBrandName() const;

    [[nodiscard]]
    QString getCarModel() const;

    [[nodiscard]]
    QString getComment() const;

    [[nodiscard]]
    QString getMasterFullName() const;

    [[nodiscard]]
    QString getServiceProvided() const;

    [[nodiscard]]
    int getRepairAmount() const;

    [[nodiscard]]
    std::chrono::year_month_day getVisitDate() const;

    [[nodiscard]]
    QString getStatus() const;

    Record* setStatus(const QString& status);

    Record* addService(const QString& serviceProvided);

    [[nodiscard]]
    QString toString() const;
};