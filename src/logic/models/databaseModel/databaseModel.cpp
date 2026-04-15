#include "databaseModel.h"


enum Roles
{
    IdRole = Qt::UserRole + 1,
    ClientFullName,
    ClientShortName,
    PhoneNumber,
    Email,
    CarBrand,
    CarModel,
    Comment,
    MasterFullName,
    MasterShortName,
    ServiceProvided,
    Price,
    Status,
    Date
};

DatabaseModel::DatabaseModel(QObject* parent) : QAbstractListModel(parent) {}

int DatabaseModel::rowCount(const QModelIndex&) const
{
    return records.count();
}

QVariant DatabaseModel::data(const QModelIndex& index, const int role) const
{
    if (!index.isValid() || index.row() >= records.size()) return {};
    const auto&[
        idRole,
        clientFullName,
        clientShortName,
        phoneNumber,
        email,
        carBrand,
        carModel,
        comment,
        masterFullName,
        masterShortName,
        serviceProvided,
        price,
        status,
        date] = records[index.row()];

    if (role == IdRole) return idRole;
    if (role == ClientFullName) return clientFullName;
    if (role == ClientShortName) return clientShortName;
    if (role == PhoneNumber) return phoneNumber;
    if (role == Email) return email;
    if (role == CarBrand) return carBrand;
    if (role == CarModel) return carModel;
    if (role == Comment) return comment;
    if (role == MasterFullName) return masterFullName;
    if (role == MasterShortName) return masterShortName;
    if (role == ServiceProvided) return serviceProvided;
    if (role == Price) return price;
    if (role == Status) return status;
    if (role == Date) return date;
    return {};
}

QHash<int, QByteArray> DatabaseModel::roleNames() const
{
    return
    {
        {IdRole, "idRole"},
        {ClientFullName, "clientFullName"},
        {ClientShortName, "clientShortName"},
        {PhoneNumber, "phoneNumber"},
        {Email, "email"},
        {CarBrand, "carBrand"},
        {CarModel, "carModel"},
        {Comment, "comment"},
        {MasterFullName, "masterFullName"},
        {MasterShortName, "masterShortName"},
        {ServiceProvided, "serviceProvided"},
        {Price, "price"},
        {Status, "status"},
        {Date, "date"}
    };
}

void DatabaseModel::update()
{
    update("none", "");
}

void DatabaseModel::update(const QString& sortTag, const QString& search)
{
    Database& database = Database::getInstance();
    QList processedRecords {database.getRecords(sortTag, search)};
    QList<SimpleRecord> newRecords {};

    for (const auto& record : processedRecords)
        newRecords.push_back(record.toSimpleRecord());

    beginResetModel();
    records = newRecords;
    endResetModel();
}

void DatabaseModel::setStatus(const QString &id, const QString &status)
{
    Database& database = Database::getInstance();
    database.setStatus(id.toInt(), status);
}