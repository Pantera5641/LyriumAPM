#include "simpleRecord.h"


QString SimpleRecord::toString() const
{
    QString str
    {
        id + ";" +
        clientFullName + ";" +
        clientShortName + ";" +
        phoneNumber + ";" +
        email + ";" +
        carBrand + ";" +
        carModel + ";" +
        comment + ";" +
        masterFullName + ";" +
        masterShortName + ";" +
        serviceProvided + ";" +
        price + ";" +
        status + ";" +
        date
    };
    return str;
}