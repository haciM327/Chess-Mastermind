#ifndef ANALYZER_H
#define ANALYZER_H
#include <QtCore/qcontainerfwd.h>
#include <string>
#include <vector>
#include <QPointer>
#include "../include/chess.hpp"
#include <QString>
#include <QStringList>
#include <QMetaType>
#include <QObject>
#ifdef _WIN32
    #include <windows.h>
#else
    #include <unistd.h>
    #include <signal.h>
    #include <sys/wait.h>
#endif

struct game_data {
    Q_GADGET

    Q_PROPERTY(QString event MEMBER event);
    Q_PROPERTY(QString site MEMBER site);
    Q_PROPERTY(QString date MEMBER date);
    Q_PROPERTY(QString round MEMBER round);
    Q_PROPERTY(QString white MEMBER white);
    Q_PROPERTY(QString black MEMBER black);
    Q_PROPERTY(QString result MEMBER result);
    Q_PROPERTY(QStringList moves MEMBER moves);


    public:
        QString event;
        QString site;
        QString date;
        QString round;
        QString white;
        QString black;
        QString result;
        QStringList moves;
};

Q_DECLARE_METATYPE(game_data)

struct move_data {
    Q_GADGET

    Q_PROPERTY(QString best_move MEMBER best_move);
    Q_PROPERTY(int eval MEMBER eval);
    Q_PROPERTY(QString move_type MEMBER move_type);
    Q_PROPERTY(QString fen MEMBER fen);
    Q_PROPERTY(QString move MEMBER move);

    public:
        QString best_move;
        int eval;
        QString move_type;
        QString fen;
        QString move;

};

struct values {
    int queen;
    int rook;
    int bishop;
    int knight;
    int pawn;
};

struct all_data {
    std::vector<move_data> info_list;
    game_data headers;
};

Q_DECLARE_METATYPE(move_data)

class Analyzer : public QObject {

    Q_OBJECT

    public:
        Analyzer(const std::string& engine_path, int depth, const std::string& game_path, int threads);
        all_data data;
        #ifdef _WIN32
            PROCESS_INFORMATION pi;
        #else
            pid_t pid;
        #endif

        void setup_pipes();

        void quit();

    private:
        int depth, threads;
        std::string engine_path, game_path;

        // Functions
        std::vector<int> get_eval(FILE* &read_pipe, FILE* &write_pipe, int depth);
        void analyze(int read_fd, int write_fd, const std::string& engine_path, int depth, const std::string& game_path, int threads);

        game_data read_pgn(const std::string& f);
        std::vector<int> get_attackers(std::string fen, std::string targetSquare_string, chess::Board &board);

    signals:
        void finished();


};



class PGNParser : public chess::pgn::Visitor {
    public:
        game_data game;
        virtual ~PGNParser();
        void startPgn();
        void header(std::string_view key, std::string_view value);
        void startMoves();
        void move(std::string_view move, std::string_view comment);
        void endPgn();
};


    extern QPointer<QObject> qfuncs;
#endif
