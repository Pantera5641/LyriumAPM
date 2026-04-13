#include "tagListModel.h"


enum Roles { NameRole = Qt::UserRole + 1, TagRole };

TagListModel::TagListModel(const QList<TagItem>& items, QObject* parent)
    : QAbstractListModel(parent), items(items) {}

int TagListModel::rowCount(const QModelIndex&) const
{
    return items.count();
}

QVariant TagListModel::data(const QModelIndex& index, const int role) const
{
    if (!index.isValid() || index.row() >= items.size()) return {};
    const auto&[name, tag] = items[index.row()];
    if (role == NameRole) return name;
    if (role == TagRole) return tag;
    return {};
}

QHash<int, QByteArray> TagListModel::roleNames() const
{
    return { {NameRole, "name"}, {TagRole, "tag"} };
}

QString TagListModel::getTag(const int index) const
{
    if (index < 0 || index >= items.size()) return {};
    return items.at(index).tag;
}