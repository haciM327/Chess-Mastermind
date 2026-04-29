#ifndef QMLFUNCS_H
#define QMLFUNCS_H

#include <QObject>
#include <QQmlEngine>
#include "../include/analyzer.hpp"
#include <curl/curl.h>

class Qmlfuncs : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Qmlfuncs(QObject *parent = nullptr);


    Q_INVOKABLE void addGame(QString pgn, QString name);

    Q_INVOKABLE QList<QString> getGames();

    Q_INVOKABLE void download(QString url, QString name, QString type);

    void move_engine(QString name, std::string type);

    static int progress_callback(void *clientp,curl_off_t dltotal,curl_off_t dlnow,curl_off_t ultotal,curl_off_t ulnow);

    Q_INVOKABLE QList<QString> getEngines();

    Q_INVOKABLE QString getos();

    Q_INVOKABLE QString getarch();

    Q_INVOKABLE void runAnalyzer(QString game, QString engine, QString depth, QString threads);

    Q_INVOKABLE QString get_fen();

    Q_INVOKABLE move_data move_ahead();

    Q_INVOKABLE move_data move_back();

    Q_INVOKABLE int get_move_num();

    Q_INVOKABLE game_data get_headers();

    bool port;

    QString fen;

    all_data data;

    int current_move = 0;

    struct progress {
        curl_off_t bytesDownloaded;
        curl_off_t totalSize;

        progress() : bytesDownloaded(0), totalSize(0) {}
    };

signals:
};

#endif // QMLFUNCS_H
