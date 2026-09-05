/*
    Chess Mastermind analyzes chess games using a chess engine
    Copyright (C) 2026  Micah Schwab

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include <dirent.h>
#include <QObject>
#include <QPointer>
#include "../include/analyzer.hpp"
#include "../include/funcs.hpp"

int main(int argc, char *argv[])
{
    // Resets log
    open_file();


    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;

    qRegisterMetaType<game_data>("game_data");
    qRegisterMetaType<move_data>("move_data");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, [](const QUrl &url) {
                         qCritical() << "QML Engine failed to compile or load target:" << url;
                         QCoreApplication::exit(1);
                     }, Qt::QueuedConnection);

    #ifdef _WIN32
        QString appDir = QCoreApplication::applicationDirPath();
        qDebug() << appDir << "\n";
        engine.load(QUrl::fromLocalFile(appDir + "/qml/main.qml"));
    #else
        if (is_installed()) {
            engine.load(QUrl(QStringLiteral("/usr/local/share/chess_mastermind/qml/main.qml")));
        } else {
            engine.load(QUrl(QStringLiteral("qml/main.qml")));
        }
    #endif

        if (engine.rootObjects().isEmpty()) {
            qCritical() << "Could not load engine";
            return -1;
        }
    QObject *root = engine.rootObjects().first(); // root QML object
    QObject *funcObject = root->findChild<QObject*>("funcs", Qt::FindChildrenRecursively);

    if (!funcObject) {
        qCritical() << "Backend 'funcs' object not found in main.qml!";
        return 1;
    }

    for (int i = 0; i < funcObject->metaObject()->methodCount(); i++) {
        QMetaMethod method = funcObject->metaObject()->method(i);
    }
    if (!funcObject) {
        qWarning() << "backend object not found";
    }
    qfuncs = funcObject;

    return app.exec();
}
