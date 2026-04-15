#pragma once
#include <QString>
#include <QList>
#include <QFile>
#include <QTextStream>
#include <qcoreapplication.h>

#include "src/logic/models/tagListModel/tagItem.h"
#include "src/logic/models/tagListModel/tagListModel.h"


class Utils
{
    public:
    static QList<TagItem> parseToModel(const QString &filename);

    static QString tagToName(const QString &filename, const QString &tag);
};
