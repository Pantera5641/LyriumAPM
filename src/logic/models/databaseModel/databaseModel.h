#pragma once
#include <QAbstractListModel>

#include "shortRecord.h"
#include "../../../database/database.h"


class DatabaseModel : public QAbstractListModel
{
    private:
    QList<ShortRecord> records {};

    Q_OBJECT
    public:
    explicit DatabaseModel(QObject* parent = nullptr);

    [[nodiscard]]
    int rowCount(const QModelIndex &) const override;

    [[nodiscard]]
    QVariant data(const QModelIndex &index, int role) const override;

    [[nodiscard]]
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE
    void updateDatabase(const QString& sortTag, const QString& search);
};
