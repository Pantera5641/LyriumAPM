#pragma once
#include <QString>

struct SimpleRecord
{
    QString id {};
    QString clientFullName {};
    QString clientShortName {};
    QString phoneNumber {};
    QString email {};
    QString carBrand {};
    QString carModel {};
    QString comment {};
    QString masterFullName {};
    QString masterShortName {};
    QString serviceProvided {};
    QString price {};
    QString status {};
    QString date {};

    [[nodiscard]]
    QString toString() const;
};