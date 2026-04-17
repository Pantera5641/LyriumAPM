#pragma once
#include <QFile>
#include <QTextStream>
#include <qcoreapplication.h>
#include <chrono>
#include <utility>
#include <fstream>
#include <map>
#include <QDate>

#include "../utils/utils.h"
#include "simpleRecord.h"


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
    QDate visitDate {};
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
        QDate visitDate,
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
        const QDate& visitDate,
        const QString& status);

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
    QDate getVisitDate() const;

    [[nodiscard]]
    QString getVisitDateYMN() const;

    [[nodiscard]]
    QString getVisitDateDMY() const;

    [[nodiscard]]
    QString getStatus() const;

    [[nodiscard]]
    QString getFieldByTag(const QString& tag) const;

    Record* setStatus(const QString& status);

    Record *setDate(const QString &date);

    void setValueByTag(const QString &tag, const QString &value);

    Record* addService(const QString& serviceProvided);

    [[nodiscard]]
    QString toString() const;

    [[nodiscard]]
    SimpleRecord toSimpleRecord() const;
};