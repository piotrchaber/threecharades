#include "ResultFile.h"

#include <sstream>
#include <iostream>
#include <QFile>
#include <QTextStream>

QString ResultFile::m_format = "dd.MM.yyyy";

ResultFile::ResultFile(QObject * parent) : QObject(parent)
{}

ResultFile::ResultFile(const QString & path, QObject * parent)
    : m_path(path), QObject(parent)
{
    read();
}

ResultFile::~ResultFile()
{}

const QStringList & ResultFile::data() const
{
    return m_data;
}

void ResultFile::insert(int score, const QString & nick)
{
    auto lambda = [](const ResultFile::Result & left, const ResultFile::Result & right) {
        if (left.score == right.score) {
            return left.date > right.date;
        }
        return left.score < right.score;
    };
    auto result = ResultFile::Result{score, nick, QDate::currentDate()};
    auto upper = std::upper_bound(m_results.begin(), m_results.end(), result, lambda);
    m_data.insert(std::distance(m_results.begin(), upper), parser(result));
    m_results.insert(upper, result);
    emit resultsChanged();
}

const QString & ResultFile::path() const
{
    return m_path;
}

const QVector<ResultFile::Result> & ResultFile::results() const
{
    return m_results;
}

void ResultFile::setPath(const QString & path)
{
    m_path = path;
    read();
    emit pathChanged();
}

void ResultFile::write()
{
    QFile file(m_path);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream stream(&file);
        for (const auto & result : m_results) {
            stream << parser(result) << '\n';
        }
    }
}

QString ResultFile::parser(const ResultFile::Result & result)
{
    return QString("%1 %2 %3").arg(result.score).arg(result.nick).arg(result.date.toString(m_format));
}

ResultFile::Result ResultFile::parser(const QString & result)
{
    int score;
    std::string nick;
    std::string date;

    std::stringstream ss(result.toStdString());
    ss >> score >> nick >> date;

    return {score, QString::fromStdString(nick), QDate::fromString(QString::fromStdString(date), m_format)};
}

void ResultFile::read()
{
    QString line;
    QFile file(m_path);
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        while (!file.atEnd())
        {
            line = file.readLine();
            m_data.append(line.remove(QRegExp("[\r\n]")));
            m_results.push_back(parser(line));
        }
    }
    emit dataChanged();
    emit resultsChanged();
}

// idea: delete m_data and use parser to qstring or smth like that
