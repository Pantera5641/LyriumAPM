#include "record.h"


Record::Record(
    const int id,
    const std::string &clientName,
    const std::string &phoneNumber,
    const std::string &email,
    const std::string &carBrandName,
    const std::string &carModel,
    const std::string &comment,
    const std::string &masterFullName,
    const std::string &serviceProvided,
    const int repairAmount,
    const std::chrono::year_month_day &visitDate,
    const std::string &status) {
    this->id = id;
    this->clientName = clientName;
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
    const std::string& clientName,
    const std::string& phoneNumber,
    const std::string& email,
    const std::string& carBrandName,
    const std::string& carModel,
    const std::string& comment,
    const std::string& masterFullName,
    const std::string& serviceProvided,
    const std::chrono::year_month_day& visitDate,
    const std::string& status) {
    this->id = id;
    this->clientName = clientName;
    this->phoneNumber = phoneNumber;
    this->email = email;
    this->carBrandName = carBrandName;
    this->carModel = carModel;
    this->comment = comment;
    this->masterFullName = masterFullName;
    this->serviceProvided = serviceProvided;
    this->visitDate = visitDate;
    this->status = status;
    for (auto item : Utils::split(serviceProvided, ';'))
        updateRepairAmount(item);
}

void Record::updateRepairAmount(const std::string& serviceProvided)
{
    int amount {};
    std::map <std::string, int> servicesList {};
    std::ifstream file("data/servicesList.txt");
    std::string line;

    while (std::getline(file, line))
    {
        std::vector tokens {Utils::split(line, ';')};
        servicesList.insert(std::make_pair(tokens.at(1), std::stoi(tokens.at(2))));
    }

    if (const auto pair = servicesList.find(serviceProvided); pair != servicesList.end())
        amount+=pair->second;

    repairAmount += amount;
}

int Record::getId() const {return id;}

std::string Record::getClientName() const {return clientName;}

std::string Record::getPhoneNumber() const {return phoneNumber;}

std::string Record::getEmail() const {return email;}

std::string Record::getCarBrandName() const {return carBrandName;}

std::string Record::getCarModel() const {return carModel;}

std::string Record::getComment() const {return comment;}

std::string Record::getMasterFullName() const {return masterFullName;}

std::string Record::getServiceProvided() const {return serviceProvided;}

int Record::getRepairAmount() const {return repairAmount;}

std::chrono::year_month_day Record::getVisitDate() const {return visitDate;}

std::string Record::getStatus() const {return status;}

Record* Record::setStatus(const std::string& status)
{
    this->status = status;
    return this;
}

Record* Record::addService(const std::string& serviceProvided)
{
    if (this->serviceProvided.empty())
        this->serviceProvided = serviceProvided;

    if (this->serviceProvided.find(serviceProvided) == std::string::npos)
    {
        this->serviceProvided += ";" + serviceProvided;
    }
    else
    {
        throw std::runtime_error("Service provided " + serviceProvided);
    }
    return this;
}

std::string Record::toString() const
{
    const std::string data
    {
        std::to_string(static_cast<int>(this->visitDate.year())) + '.' +
            std::to_string(static_cast<unsigned>(this->visitDate.month())) + '.' +
                std::to_string(static_cast<unsigned>(this->visitDate.day()))
    };

    return std::to_string(this->id) + ',' + this->clientName + ',' + this->phoneNumber + ',' + this->email + ',' +
        this->carBrandName + ',' + this->carModel + ',' + this->comment + ',' + this->masterFullName + ',' +
            this->serviceProvided + ',' + std::to_string(this->repairAmount) + ',' + data + ',' + this->status;
}