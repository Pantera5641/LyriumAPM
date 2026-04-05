#include "utils.h"


std::vector<std::string> Utils::split(const std::string& str,const char delimiter)
{
    std::vector<std::string> result;
    std::stringstream ss(str);
    std::string token;

    while (std::getline(ss, token, delimiter))
    {
        result.push_back(token);
    }

    return result;
}
