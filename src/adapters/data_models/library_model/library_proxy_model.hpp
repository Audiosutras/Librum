#pragma once
#include <QSortFilterProxyModel>
#include <vector>
#include "filter_request.hpp"
#include "tag_dto.hpp"

namespace adapters::data_models
{

/**
 * The LibraryProxyModel class is a proxy class which acts as a wrapper around
 * the library model that is handling the sorting and filtering of elements
 */
class LibraryProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(
        QString sortString READ getSortString WRITE setSortString CONSTANT)
    Q_PROPERTY(int sortRole READ getSortRole WRITE setSortRole CONSTANT)

public:
    enum SortRole
    {
        RecentlyAdded = Qt::UserRole + 1,
        Title,
        Authors,
        LastOpened
    };

    Q_ENUM(SortRole);

    explicit LibraryProxyModel(QObject* parent = nullptr);

    bool lessThan(const QModelIndex& left,
                  const QModelIndex& right) const override;
    bool filterAcceptsRow(int source_row,
                          const QModelIndex& source_parent) const override;

    Q_INVOKABLE void setFilterRequest(QString authors, QString format,
                                      QString date, bool onlyBooks,
                                      bool onlyFiles, bool read, bool unread);
    Q_INVOKABLE void addFilterTag(QString tag);
    Q_INVOKABLE void removeFilterTag(QString tag);
    Q_INVOKABLE void clearFilterTags();

    void setSortRole(int newRole);
    int getSortRole();

    void setSortString(QString newSortString);
    QString getSortString();

signals:
    void sortStringUpdated();

private:
    double fuzzCompareWithSortingString(QString lhs) const;
    bool stringIsLexicographicallyLess(const QString& left,
                                       const QString& right) const;
    bool openedAfter(const QModelIndex& left, const QModelIndex& right) const;
    bool addedToLibraryAfter(const QModelIndex& left,
                             const QModelIndex& right) const;
    bool bookContainsAllTags(std::vector<adapters::dtos::TagDto> tags) const;

    FilterRequest m_filterRequest;
    QString m_sortString = "";
    std::vector<QString> m_tags;
    SortRole m_sortRole = SortRole::RecentlyAdded;
};

}  // namespace adapters::data_models