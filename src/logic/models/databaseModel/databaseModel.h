#pragma once
#include <QAbstractListModel>

#include "../../../database/simpleRecord.h"
#include "../../../database/database.h"


class DatabaseModel : public QAbstractListModel
{
    private:
    QList<SimpleRecord> records {};

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
    void update();

    Q_INVOKABLE
    void update(const QString& sortTag, const QString& search);

    Q_INVOKABLE
    static void setStatus(const QString& id, const QString& status);
};
