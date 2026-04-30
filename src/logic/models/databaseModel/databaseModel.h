#pragma once
#include <QAbstractListModel>
#include <QDebug>

#include "../../../database/simpleRecord.h"
#include "../../../database/database.h"


class DatabaseModel : public QAbstractListModel
{
    Q_OBJECT
    private:
    QList<SimpleRecord> records {};
    QList<SimpleRecord> cashRecords {};

    Q_PROPERTY(QVariantList pieSeriesModel READ pieSeriesModel NOTIFY pieSeriesModelChanged);
    Q_PROPERTY(QVariantList barSeriesModel READ barSeriesModel NOTIFY barSeriesModelChanged);
    Q_PROPERTY(int size READ size NOTIFY updated);

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

    Q_INVOKABLE
    static void setValueByIdTag(const QString& id, const QString& tag, const QString& value);

    Q_INVOKABLE
    QVariantMap getById(int id);

    Q_INVOKABLE [[nodiscard]]
    int size() const;

    Q_INVOKABLE
    QVariantList pieSeriesModel();

    Q_INVOKABLE
    QVariantList barSeriesModel();

    signals:
    void updated();
    void pieSeriesModelChanged();
    void barSeriesModelChanged();
};
