#include "record.h"


Container::Container(std::vector<std::string> fields)
{
    this->fields = fields;
}

std::string Container::getItem(int num)
{
    return this->fields[num];
}

std::vector<std::string> Container::getFields()
{
    return fields;
}