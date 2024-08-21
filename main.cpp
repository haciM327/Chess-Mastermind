#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <dirent.h>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");
    QQmlApplicationEngine engine;
    #ifdef _WIN32 || WIN64
        engine.load(QUrl(QStringLiteral("../share/chess-mastermind/main.qml")));
    #else
        DIR *pDir;
        bool bExists = false;
    
        pDir = opendir ("../share");
    
        if (pDir != NULL)
        {
            bExists = true;
            (void) closedir (pDir);
        }

        if (bExists) {
            engine.load(QUrl(QStringLiteral("../share/chess-mastermind/main.qml")));
        } else {
            engine.load(QUrl(QStringLiteral("/usr/local/main.qml")));
        }
    #endif
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
