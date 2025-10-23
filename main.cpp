#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <dirent.h>
#include <QObject>
#include "analyzer/analyzer.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");

    QQmlApplicationEngine engine;

    qRegisterMetaType<game_data>("game_data");
    qRegisterMetaType<move_data>("move_data");

    engine.load(QUrl(QStringLiteral("qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
