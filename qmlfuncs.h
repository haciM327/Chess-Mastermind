#ifndef QMLFUNCS_H
#define QMLFUNCS_H

#include <QObject>
#include <QQmlEngine>

class Qmlfuncs : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Qmlfuncs(QObject *parent = nullptr);

    Q_INVOKABLE void addGame(QString pgn, QString name);

    Q_INVOKABLE QList<QString> getGames();

    Q_INVOKABLE QList<QString> getEngines();

    Q_INVOKABLE void runAnalyzer(QString game, QString engine, QString depth);

signals:
};

#endif // QMLFUNCS_H