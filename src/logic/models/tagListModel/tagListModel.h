#pragma once
#include <QAbstractListModel>

#include "tagItem.h"


using DataMethod = std::function<QList<TagItem>()>;

class TagListModel : public QAbstractListModel
{
    private:
    QList<TagItem> items;
    DataMethod dataMethod;

    Q_OBJECT
    public:
    explicit TagListModel(const QList<TagItem>& items, QObject* parent = nullptr);

    [[nodiscard]]
    int rowCount(const QModelIndex &) const override;

    [[nodiscard]]
    QVariant data(const QModelIndex &index, int role) const override;

    [[nodiscard]]
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE [[nodiscard]]
    QString getTag(int index) const;
};
