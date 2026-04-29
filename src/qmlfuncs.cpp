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

#include "../include/qmlfuncs.h"
#include <fstream>
#include <filesystem>
#include <dirent.h>
#include <iostream>
#include <string>
#include <filesystem>
#include <curl/curl.h>
#include <QtConcurrent/QtConcurrent>
#include <QMetaObject>
#include <cctype>
//#include <QVariant>
#include <archive.h>
#include <archive_entry.h>
#include "../include/analyzer.hpp"
#include "../include/funcs.hpp"
#ifdef _WIN32
    #include <windows.h>
    #include <tchar.h>
#else
    #include <unistd.h>
    #include <sys/types.h>
    #include <sys/wait.h>
#endif

using namespace std;
namespace fs = std::filesystem;

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

void Qmlfuncs::download(QString url, QString name, QString type) {
    QtConcurrent::run([this, url, name, type]{
        // Initializes curl
        if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK) {
            std::cerr << "Error initializing libcurl." << std::endl;
        }

        // Initializes variables
        CURL *curl = curl_easy_init();
        progress Downloadprogress;
        CURLcode res;
        FILE *file;

        if (!curl) {
            std::cerr << "Error initializing curl." << std::endl;
            return;
        }

        curl_easy_setopt(curl, CURLOPT_URL, url.toStdString().c_str());
        curl_easy_setopt(curl, CURLOPT_XFERINFODATA, &Downloadprogress);
        curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, progress_callback);
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L); // Enable progress data
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);

        // Open file hanndle for writing
        file = fopen("stockfish.tar", "wb");
        if (!file) {
            std::cerr << "Error opening file for writing" << std::endl;
            curl_easy_cleanup(curl);
            return;
        }

        // Set file as the target for the download
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, file);

        // Perform the request
        res = curl_easy_perform(curl);

        // Check for errors
        if (res != CURLE_OK) {
            std::cerr << "\ncurl_easy_perform() failed: " << curl_easy_strerror(res) << std::endl;
            return;
        } else {
            std::cout << "\nDownload completed successfully!" << std::endl;
        }

        move_engine(name, type.toStdString());
    });
}

void Qmlfuncs::move_engine(QString name, std::string type) {
    struct archive* a = archive_read_new();
       archive_read_support_format_all(a);
       archive_read_support_filter_all(a);

       if (archive_read_open_filename(a, "stockfish.tar", 10240) != ARCHIVE_OK) {
           std::cerr << archive_error_string(a) << "\n";
           return;
       }

       struct archive_entry* entry;
       int found = 0;

       std::transform(type.begin(), type.end(), type.begin(),
           [](unsigned char c){ return std::tolower(c); });
       std::string path = "stockfish/stockfish-" + getos().toStdString() + "-" + getarch().toStdString() + "-" + type ;
       if (getos() == "windows") {path += ".exe";}
       while (archive_read_next_header(a, &entry) == ARCHIVE_OK) {
           std::string current = archive_entry_pathname(entry);
           std::cout << "Entry: [" << current << "]\n";

           if (current == path) {
               found = 1;

               std::ofstream file("./engines/" + name.toStdString(), std::ios::binary);
               cout << name.toStdString() << endl;
               if (!file) {
                   std::cerr << "Failed to open output file\n";
                   if (!QMetaObject::invokeMethod(qfuncs, "finished_download", Qt::QueuedConnection)) {
                       log("Failed to call loading screen method\n");
                       }
                   return;
               }

               const void* buff;
               size_t size;
               la_int64_t offset;

               while (true) {
                   int r = archive_read_data_block(a, &buff, &size, &offset);
                   if (r == ARCHIVE_EOF)
                       break;
                   if (r != ARCHIVE_OK) {
                       std::cerr << archive_error_string(a) << "\n";
                       return;
                   }
                   file.write(static_cast<const char*>(buff), size);
               }

               file.close();
               break; // stop after finding the file
           } else {
               archive_read_data_skip(a);
           }
       }

       archive_read_free(a);

       if (!found) {
           std::cerr << "File not found in archive\n";
           return;
       }

       string command = std::string("chmod 755 ./engines/") + name.toStdString();
       system(command.c_str());
       if (!QMetaObject::invokeMethod(qfuncs, "finished_download", Qt::QueuedConnection)) {
           log("Failed to call loading screen method\n");
           }
       return;
}

int Qmlfuncs::progress_callback(void *clientp,curl_off_t dltotal,curl_off_t dlnow,curl_off_t ultotal,curl_off_t ulnow) {
        double percent = (dltotal > 0) ? (dlnow * 100.0 / dltotal) : 0.0;
        if (!QMetaObject::invokeMethod(qfuncs, "reportProgress", Qt::QueuedConnection, Q_ARG(int, percent))) {
            log("Failed to call loading screen method\n");
        }
        return 0;
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
    #elif __APPLE__ || __MACH
        return "macos";
    #elif __linux__
        // ubuntu for stockfish downloads used in config_engine.qml
        return "ubuntu";
    #endif
}

QString Qmlfuncs::getarch() {
    #if defined(__aarch64__)
        return "apple-silicon";
    #elif defined(__x86_64__)
        return "x86-64";
    #endif
}

void Qmlfuncs::runAnalyzer(QString game, QString engine, QString depth, QString threads) {
    QtConcurrent::run([this, game, engine, depth, threads]{
        int thread_num;
        int depth_num;

        // Checks thread to depth to ensure inputted value is an int
        // Defaults to 1 or 18 otherwise
        if (threads.toInt() == 0) {
            log("Thread count must be an integer greater than 0. Defaulting to 1.\n");
            thread_num = 1;
        } else {
            thread_num = threads.toInt();
        }

        if (depth.toInt() == 0) {
            log("Depth count must be an integer greater than 0. Defaulting to 18.\n");
            depth_num = 18;
        } else {
            depth_num = depth.toInt();
        }

        // Runs the analyzer in the seperate thread created by QtConcurrent
        // This ensures the loading screen and progress bar can be updated without stalling the application
        this->data = setup_pipe(engine.toStdString(), depth_num, game.toStdString(), thread_num);
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
