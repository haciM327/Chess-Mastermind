#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
<<<<<<< Updated upstream
=======
#include <QQmlContext>
#include <dirent.h>
#include <QObject>
#include <QPointer>
#include "analyzer/analyzer.hpp"

>>>>>>> Stashed changes
int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    QObject *root = engine.rootObjects().first(); // root QML object
    QObject *funcObject = root->findChild<QObject*>("funcs", Qt::FindChildrenRecursively);


    for (int i = 0; i < funcObject->metaObject()->methodCount(); i++) {
        QMetaMethod method = funcObject->metaObject()->method(i);
        qDebug() << method.methodSignature();
    }
    qDebug() << funcObject->metaObject()->indexOfMethod("reportProgress(double)");
    if (!funcObject) {
        qWarning() << "backend object not found";
    }
    qfuncs = funcObject;

    return app.exec();
}
