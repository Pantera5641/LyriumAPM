#pragma once
#include <QString>
#include <QList>
#include <QFile>
#include <QTextStream>
#include <qcoreapplication.h>

#include "src/logic/tagListModel/tagItem.h"
#include "src/logic/tagListModel/tagListModel.h"


class Utils
{
    public:
    static QList<TagItem> parseToModel(const QString &filename);
};
