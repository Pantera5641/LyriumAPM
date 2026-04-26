#pragma once
#include <QString>
#include <QList>
#include <QFile>
#include <QTextStream>
#include <qcoreapplication.h>

#include "../logic/models/tagListModel/tagItem.h"
#include "../logic/models/tagListModel/tagListModel.h"


class Utils
{
    public:
    static QList<TagItem> parseToModel(const QString &filename);

    static QString tagToName(const QString &filename, const QString &tag);

    static QStringList find(const QString &filename, const QString &tag);
};
