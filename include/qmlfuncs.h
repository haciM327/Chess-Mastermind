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


    Q_INVOKABLE void addGame(const QString& pgn, const QString& name) const;

    Q_INVOKABLE QList<QString> getGames() const;

    Q_INVOKABLE void download(const QString& url, const QString& name);

    void move_engine(const QString& name) const;

    static int progress_callback(void *clientp,curl_off_t dltotal,curl_off_t dlnow,curl_off_t ultotal,curl_off_t ulnow);

    Q_INVOKABLE QList<QString> getEngines() const;

    Q_INVOKABLE static QString getOs();

    Q_INVOKABLE static QString getArch();

    Q_INVOKABLE void runAnalyzer(QString game, QString engine, QString depth, QString threads);

    Q_INVOKABLE QString get_fen();

    Q_INVOKABLE move_data move_ahead();

    Q_INVOKABLE move_data move_back();

    Q_INVOKABLE int get_move_num() const;

    Q_INVOKABLE game_data get_headers() const;

    bool port{};

    QString fen;

    all_data data;

    int current_move = 0;

    struct progress {
        curl_off_t bytesDownloaded;
        curl_off_t totalSize;

        progress() : bytesDownloaded(0), totalSize(0) {}
    };

private:
    Analyzer *ana{};
    bool installed;
    std::string resource_path;

signals:
    void app_quit();

public slots:
    void analyzer_finished();
};

#endif // QMLFUNCS_H
