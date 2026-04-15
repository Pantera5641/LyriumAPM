#include "record.h"


Record::Record(
    const int id,
    const QString &clientFullName,
    const QString &phoneNumber,
    const QString &email,
    const QString &carBrandName,
    const QString &carModel,
    const QString &comment,
    const QString &masterFullName,
    const QString &serviceProvided,
    const int repairAmount,
    const std::chrono::year_month_day &visitDate,
    const QString &status) {
    this->id = id;
    this->clientFullName = clientFullName;
    this->phoneNumber = phoneNumber;
    this->email = email;
    this->carBrandName = carBrandName;
    this->carModel = carModel;
    this->comment = comment;
    this->masterFullName = masterFullName;
    this->serviceProvided = serviceProvided;
    this->repairAmount = repairAmount;
    this->visitDate = visitDate;
    this->status = status;
}

Record::Record(
    const int id,
    const QString& clientFullName,
    const QString& phoneNumber,
    const QString& email,
    const QString& carBrandName,
    const QString& carModel,
    const QString& comment,
    const QString& masterFullName,
    const QString& serviceProvided,
    const std::chrono::year_month_day& visitDate,
    const QString& status) {
    this->id = id;
    this->clientFullName = clientFullName;
    this->phoneNumber = phoneNumber;
    this->email = email;
    this->carBrandName = carBrandName;
    this->carModel = carModel;
    this->comment = comment;
    this->masterFullName = masterFullName;
    this->serviceProvided = serviceProvided;
    this->visitDate = visitDate;
    this->status = status;
    for (auto item : serviceProvided.split(','))
        updateRepairAmount(item);
}

void Record::updateRepairAmount(const QString& serviceProvided)
{
    int amount {};
    std::map <QString, int> servicesList {};

    QFile file(QCoreApplication::applicationDirPath() + "/data/servicesList.txt");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream stream(&file);
    while (!stream.atEnd())
    {
        QString line = stream.readLine();
        QStringList tokens = line.split(';');
        servicesList.insert(std::make_pair(tokens.at(1), tokens.at(2).toInt()));
    }

    if (const auto pair = servicesList.find(serviceProvided); pair != servicesList.end())
        amount+=pair->second;

    file.close();

    repairAmount += amount;
}

int Record::getId() const {return id;}

QString Record::getClientFullName() const {return clientFullName;}

QString Record::getPhoneNumber() const {return phoneNumber;}

QString Record::getEmail() const {return email;}

QString Record::getCarBrandName() const {return carBrandName;}

QString Record::getCarModel() const {return carModel;}

QString Record::getComment() const {return comment;}

QString Record::getMasterFullName() const {return masterFullName;}

QString Record::getServiceProvided() const {return serviceProvided;}

int Record::getRepairAmount() const {return repairAmount;}

std::chrono::year_month_day Record::getVisitDate() const {return visitDate;}

QString Record::getVisitDateYMN() const
{
    QString year {QString::number(static_cast<int>(this->visitDate.year()))};
    QString month {QString::number(static_cast<unsigned>(this->visitDate.month()))};
    QString day {QString::number(static_cast<unsigned>(this->visitDate.day()))};

    if (month.size() != 2) month = '0' + month;
    if (day.size() != 2) day = '0' + day;

    return year + '.' + month + '.' + day;
}

QString Record::getVisitDateDMY() const
{
    QString year {QString::number(static_cast<int>(this->visitDate.year()))};
    QString month {QString::number(static_cast<unsigned>(this->visitDate.month()))};
    QString day {QString::number(static_cast<unsigned>(this->visitDate.day()))};

    if (month.size() != 2) month = '0' + month;
    if (day.size() != 2) day = '0' + day;

    return day + '.' + month + '.' + year;
}

QString Record::getStatus() const {return status;}

QString Record::getFieldByTag(const QString& tag) const
{
    if (tag == "id") return QString::number(this->id);
    if (tag == "client_full_name") return this->clientFullName;
    if (tag == "phone_number") return this->phoneNumber;
    if (tag == "email") return this->email;
    if (tag == "car_brand_name") return this->carBrandName;
    if (tag == "car_model") return this->carModel;
    if (tag == "comment") return this->comment;
    if (tag == "master_full_name") return this->masterFullName;
    if (tag == "service_provided") return this->serviceProvided;
    if (tag == "repair_amount") return QString::number(this->repairAmount);
    if (tag == "visit_date") return getVisitDateYMN();
    if (tag == "status") return this->status;

    throw std::runtime_error("Unknown tag");
}

Record* Record::setStatus(const QString& status)
{
    this->status = status;
    return this;
}

Record* Record::setDate(const QString& date)
{
    QList<int> ymdTokens {};
    for (const auto token : date.split('.'))
        ymdTokens.append(token.toInt());

    std::chrono::year_month_day ymd
    {
        std::chrono::year(ymdTokens.at(0)),
        std::chrono::month(ymdTokens.at(1)),
        std::chrono::day(ymdTokens.at(2))
    };
    this->visitDate = ymd;
    return this;
}

void Record::setValueByTag(const QString& tag, const QString& value)
{
    if (tag == "id") this->id = value.toInt();
    if (tag == "client_full_name") this->clientFullName;
    if (tag == "phone_number") this->phoneNumber = value;
    if (tag == "email") this->email = value;
    if (tag == "car_brand_name") this->carBrandName = value;
    if (tag == "car_model") this->carModel = value;
    if (tag == "comment") this->comment = value;
    if (tag == "master_full_name") this->masterFullName = value;
    if (tag == "service_provided") this->serviceProvided = value;
    if (tag == "repair_amount") this->repairAmount = value.toInt();
    if (tag == "visit_date") setDate(value);
    if (tag == "status") this->status = value;

    throw std::runtime_error("Unknown tag");
}

Record* Record::addService(const QString& serviceProvided)
{
    if (this->serviceProvided.isEmpty())
        this->serviceProvided = serviceProvided;

    if (this->serviceProvided.indexOf(serviceProvided) == -1)
    {
        this->serviceProvided += "," + serviceProvided;
    }
    else
    {
        throw std::runtime_error("Service provided " + serviceProvided.toStdString());
    }
    return this;
}

QString Record::toString() const
{
    return QString::number(this->id) + ';' + this->clientFullName + ';' + this->phoneNumber + ';' + this->email + ';' +
        this->carBrandName + ';' + this->carModel + ';' + this->comment + ';' + this->masterFullName + ';' +
            this->serviceProvided + ';' + QString::number(this->repairAmount) + ';' + getVisitDateYMN() + ';' + this->status;
}

SimpleRecord Record::toSimpleRecord() const
{
    SimpleRecord simpleRecord {};

    simpleRecord.id = QString::number(this->id);

    simpleRecord.clientFullName = this->clientFullName;

    const auto clientNameTokens {this->clientFullName.split(' ')};
    simpleRecord.clientShortName = clientNameTokens.at(0) + " " +
        clientNameTokens.at(1).at(0) + ". " + clientNameTokens.at(2).at(0) + ".";

    simpleRecord.phoneNumber = this->phoneNumber;

    simpleRecord.email = this->email;

    simpleRecord.carBrand = Utils::tagToName("brandList.txt", this->carBrandName);

    simpleRecord.carModel = this->carModel;

    simpleRecord.comment = this->comment;
    simpleRecord.comment.replace("\\n", "\n");

    simpleRecord.masterFullName = Utils::tagToName("employeeList.txt", this->masterFullName);

    const auto masterNameTokens {simpleRecord.masterFullName.split(' ')};
    simpleRecord.masterShortName = masterNameTokens.at(0) + " " +
        masterNameTokens.at(1).at(0) + ". " + masterNameTokens.at(2).at(0) + ".";

    //tags
    simpleRecord.serviceProvided = this->serviceProvided;

    simpleRecord.price = QString::number(this->repairAmount) + "₽";

    simpleRecord.status = Utils::tagToName("statusList.txt", this->status);

    simpleRecord.date = getVisitDateDMY();

    return simpleRecord;
}