#pragma once
#include "../../database/database.h"

class RecordPageLogic : public QObject
{
    Q_OBJECT
    public:
    explicit RecordPageLogic(QObject *parent = nullptr) : QObject(parent) {};

    Q_INVOKABLE
    static void addRecordInDataBase(
    const QString &clientFullName,
    const QString &phoneNumber,
    const QString &email,
    const QString &carBrandName,
    const QString &carModel,
    const QString &comment,
    const QString &masterFullName,
    const QString &serviceProvided);

    Q_INVOKABLE
    static QString getPrice(const QString& serviceProvided);
};
