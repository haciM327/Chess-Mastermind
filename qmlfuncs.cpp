#include "qmlfuncs.h"
#include <fstream>
#include <filesystem>
#include <dirent.h>
#include <iostream>
#include <string>
#include <QtConcurrent/QtConcurrent>
#include "./analyzer/analyzer.hpp"
#ifdef _WIN32
    #include <windows.h>
    #include <tchar.h>
#else
    #include <unistd.h>
    #include <sys/types.h>
    #include <sys/wait.h>
#endif

using namespace std;

Qmlfuncs::Qmlfuncs(QObject *parent)
    : QObject{parent}
{
    int x = 0;
}


void Qmlfuncs::addGame(QString pgn, QString name) {

#ifdef _WIN32
    std::string path = ".\\analyzer\\games\\";
#else
    std::string path = "./games/";
#endif

    path += name.toStdString().c_str();
    std::ofstream outfile (path);
    outfile << pgn.toStdString().c_str();

    outfile.close();

}

QList<QString> Qmlfuncs::getGames() {
    QString path;
#ifdef _WIN32
    path = ".\\games\\";
#else
    path = "./games/";
#endif
    QList<QString> return_value;
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 8)));
    }
    return return_value;
}

QList<QString> Qmlfuncs::getEngines() {
    QString path;
#ifdef _WIN32
    path = ".\\engines\\";
#else
    path = "./engines/";
#endif
    QList<QString> return_value;
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 10)));
    }
    return return_value;
}

QString Qmlfuncs::getos() {
    #ifdef _WIN32
        return "windows";
    #else
        return "other";
    #endif
}

void Qmlfuncs::runAnalyzer(QString game, QString engine, QString depth) {
    QtConcurrent::run([this, game, engine, depth]{
        this->data = setup_pipe(engine.toStdString(), depth.toInt(), game.toStdString());
    });
}



QString Qmlfuncs::get_fen() {
    return data.info_list[current_move].fen;
}

move_data Qmlfuncs::move_ahead() {
    // Updates the current move number
    current_move++;

    // Checks to see if the current move number is greater than the number of moves
    if (current_move > data.headers.moves.size()) {
        // If it is, it sets the current move number to the number of moves
        current_move = data.headers.moves.size();
    }

    // Updates the fen
    fen = data.info_list[current_move].fen;

    // Returns the move data
    return data.info_list[current_move];
}

move_data Qmlfuncs::move_back() {
    // Updates the current move number
    current_move--;

    // Checks to see if the current move number is less than 0
    if (current_move < 0) {
        // If it is, it sets the current move number to 0
        current_move = 0;
    }

    // Updates the fen
    fen = data.info_list[current_move].fen;

    // Returns the move data
    return data.info_list[current_move];
}

int Qmlfuncs::get_move_num() {
    return current_move;
}

game_data Qmlfuncs::get_headers() {
    return data.headers;
}
