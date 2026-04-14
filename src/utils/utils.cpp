#include "utils.h"


QList<TagItem> Utils::parseToModel(const QString &filename)
{
    QList<TagItem> items;

    QFile file(QCoreApplication::applicationDirPath() + "/data/" + filename);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream stream(&file);
    while (!stream.atEnd())
    {
        QString line = stream.readLine();
        QStringList tokens {line.split(';')};
        TagItem item;
        item.name = tokens.at(0);
        item.tag = tokens.at(1);
        items.append(item);
    }
    file.close();

    return items;
}

QString Utils::tagToName(const QString &filename, const QString &tag)
{
    if (tag == "none") return tag;

    const auto tagItems = parseToModel(filename);
    for (const auto &item : tagItems)
        if (item.tag == tag) return item.name;

    return tag;
}