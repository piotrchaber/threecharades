#ifndef RESULTFILE_H
#define RESULTFILE_H

#include <QDate>
#include <QObject>
#include <QString>
#include <QVector>

class ResultFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList data READ data NOTIFY dataChanged);
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged);
    Q_PROPERTY(QVector<Result> results READ results NOTIFY resultsChanged);

public:
    struct Result
    {
        int score;
        QString nick;
        QDate date;
    };

    ResultFile(QObject * parent = nullptr);
    explicit ResultFile(const QString & path, QObject * parent = nullptr);
    virtual ~ResultFile();

    const QStringList & data() const;
    Q_INVOKABLE void insert(int score, const QString & nick);
    const QString & path() const;
    const QVector<Result> & results() const;
    void setPath(const QString & path);
    Q_INVOKABLE void write();

signals:
    void dataChanged();
    void pathChanged();
    void resultsChanged();

private:
    QString parser(const Result & result);
    Result parser(const QString & result); 
    void read();

private:
    QString m_path;
    QStringList m_data;
    QVector<Result> m_results;
    static QString m_format;
};

#endif // RESULTFILE_H