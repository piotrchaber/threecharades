#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "DataFile.h"
#include "ResultFile.h"

#include <iostream>

int main(int argc, char** argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    DataFile passwords(QStringLiteral("input/passwords.txt"));
    engine.rootContext()->setContextProperty("passwords", &passwords);

    DataFile dictionary(QStringLiteral("input/dictionary.txt"));
    engine.rootContext()->setContextProperty("dictionary", &dictionary);

    //DataFile results(QStringLiteral("input/results.txt"));
    //engine.rootContext()->setContextProperty("results", &results);

    ResultFile test(QStringLiteral("input/test.txt"));
    engine.rootContext()->setContextProperty("test", &test);

    engine.load(QUrl(QStringLiteral("qrc:/qmls/main.qml")));
    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }
    
    return app.exec();
}