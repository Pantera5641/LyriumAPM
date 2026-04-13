#include "databaseModel.h"


enum Roles { IdRole = Qt::UserRole + 1, Username, Date, CarBrand, Price, Status };

DatabaseModel::DatabaseModel(QObject* parent) : QAbstractListModel(parent) {}

int DatabaseModel::rowCount(const QModelIndex&) const
{
    return records.count();
}

QVariant DatabaseModel::data(const QModelIndex& index, const int role) const
{
    if (!index.isValid() || index.row() >= records.size()) return {};
    const auto&[idRole, username, date, carBrand, price, status] = records[index.row()];
    if (role == IdRole) return idRole;
    if (role == Username) return username;
    if (role == Date) return date;
    if (role == CarBrand) return carBrand;
    if (role == Price) return price;
    if (role == Status) return status;
    return {};
}

QHash<int, QByteArray> DatabaseModel::roleNames() const
{
    return
    {
        {IdRole, "idRole"},
        {Username, "username"},
        {Date, "date"},
        {CarBrand, "carBrand"},
        {Price, "price"},
        {Status, "status"}
    };
}

void DatabaseModel::updateDatabase(const QString& sortTag, const QString& search)
{
    Database& database = Database::getInstance();
    QList processedRecords {database.getRecords(sortTag, search)};
    QList<ShortRecord> newRecords {};

    for (const auto& record : processedRecords)
    {
        ShortRecord newRecord {};

        newRecord.id = QString::number(record.getId());

        auto userFullName {record.getClientFullName().split(" ")};
        newRecord.username = userFullName.at(0) + " " + userFullName.at(1).at(0) + ". " + userFullName.at(2).at(0) + ".";

        auto visitDate {record.getVisitDate()};
        newRecord.date = QString("%1.%2.%3")
        .arg(static_cast<unsigned>(visitDate.day()))
        .arg(static_cast<unsigned>(visitDate.month()))
        .arg(static_cast<int>(visitDate.year()));

        newRecord.carBrand = record.getCarBrandName();

        newRecord.price = QString::number(record.getRepairAmount());

        newRecord.status = record.getStatus();

        newRecords.append(newRecord);
    }

    beginResetModel();
    records = newRecords;
    endResetModel();
}