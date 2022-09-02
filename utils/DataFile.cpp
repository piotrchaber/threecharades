#include "DataFile.h"

#include <cstdlib>

#include <QFile>
#include <QTextStream>

DataFile::DataFile(QObject * parent) : QObject(parent)
{}

DataFile::DataFile(const QString & path, QObject * parent)
    : m_path(path), QObject(parent)
{
    read();
}

DataFile::~DataFile()
{}

const QStringList & DataFile::data() const
{
    return m_data;
}

bool DataFile::find(const QString & line)
{
    return m_data.contains(line);
}

void DataFile::insert(const QString & value)
{
    m_data.insert(std::upper_bound(m_data.begin(), m_data.end(), value), value);
    emit dataChanged();
}

const QString & DataFile::line() const
{
    srand(time(nullptr));
    return m_data[rand() % m_data.length()]; // You need to make sure k != 0 holds before you compute n % k
}

const QString & DataFile::path() const
{
    return m_path;
}

void DataFile::remove(const QString & line)
{
    m_data.removeOne(line);
    emit dataChanged();
}

void DataFile::setData(const QStringList & data)
{
    m_data = data;
    emit dataChanged();
}

void DataFile::setPath(const QString & path)
{
    m_path = path;
    read();
    emit pathChanged();
}

void DataFile::write()
{
    QFile file(m_path);
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        for (const auto & record : m_data) {
            stream << record << '\n';
        }
    }
}

void DataFile::read()
{
    QString lines;
    QFile file(m_path);
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        lines = stream.readAll();
    }
    m_data = lines.split(QRegExp("[\r\n]")); // test this stuff
    emit dataChanged();
}
