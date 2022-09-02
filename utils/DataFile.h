#ifndef DATAFILE_H
#define DATAFILE_H

#include <QObject>
#include <QString>
#include <QStringList>

class DataFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList data READ data WRITE setData NOTIFY dataChanged);
    Q_PROPERTY(QString line READ line NOTIFY lineChanged);
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged);

public:
    DataFile(QObject * parent = nullptr);
    explicit DataFile(const QString & path, QObject * parent = nullptr);
    virtual ~DataFile();

    const QStringList & data() const;
    Q_INVOKABLE bool find(const QString & line);
    Q_INVOKABLE void insert(const QString & value);
    const QString & line() const;
    const QString & path() const;
    Q_INVOKABLE void remove(const QString & line);
    void setData(const QStringList & data);
    void setPath(const QString & path);
    Q_INVOKABLE void write();

private:
    void read();

signals:
    void dataChanged();
    void lineChanged();
    void pathChanged();
    
private:
    QString m_path;
    QStringList m_data;
};

#endif // DATAFILE_H
