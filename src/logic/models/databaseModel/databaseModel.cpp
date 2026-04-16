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

void DatabaseModel::setValueByIdTag(const QString &id, const QString &tag, const QString &value)
{
    Database& database = Database::getInstance();
    database.setValueByIdTag(id.toInt(), tag, value);
}

QVariantMap DatabaseModel::getById(const int id)
{
    for (const auto& record : records)
    {
        if (record.id.toInt() == id)
        {
            QVariantMap map {};

            map["idRole"] = record.id;
            map["clientFullName"] = record.clientFullName;
            map["clientShortName"] = record.clientShortName;
            map["phoneNumber"] = record.phoneNumber;
            map["email"] = record.email;
            map["carBrand"] = record.carBrand;
            map["carModel"] = record.carModel;
            map["comment"] = record.comment;
            map["masterFullName"] = record.masterFullName;
            map["masterShortName"] = record.masterShortName;
            map["serviceProvided"] = record.serviceProvided;
            map["price"] = record.price;
            map["status"] = record.status;
            map["date"] = record.date;

            return map;
        }
    }

    throw std::runtime_error("No such record in database");
}