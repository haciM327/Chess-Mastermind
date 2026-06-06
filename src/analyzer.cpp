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


#ifdef _WIN32
    #include <io.h>
    extern "C++" {
        #define WIN32_LEAN_AND_MEAN
        #define NOMINMAX
        #include <windows.h>
    }
#else
    #include <sys/select.h>
    #define _OPEN_SYS
    #include <signal.h>
    #include <unistd.h>
#endif

#include <cstddef>
#include <cstdlib>
#include <iostream>
#include <QtCore/QObject>
#include <cstdio>

#include <vector>
#include <string.h>
#include <cstring>
#include <string>
#include <fstream>
#include <fcntl.h>
#include "../include/analyzer.hpp"
#include "../include/chess.hpp"
#include "../include/funcs.hpp"
#include <QString>
#include <typeinfo>
#include <QtConcurrent/QtConcurrent>
#include <QMetaObject>
#include <QVariant>

using namespace std;
using namespace chess;

QPointer<QObject> qfuncs;


Analyzer::Analyzer(const std::string& _engine_path, int _depth, const std::string& _game_path, int _threads) {

    depth = _depth;
    threads = _threads;
    engine_path = _engine_path;
    game_path = _game_path;
}

// Function to communicate with engine
void Analyzer::analyze(int read_fd, int write_fd, const std::string& engine_path, int depth, const std::string& game_path, int threads) {

    #ifdef _WIN32
        FILE* read_pipe = _fdopen(read_fd, "r");
        FILE* write_pipe = _fdopen(write_fd, "w");
    #else
        FILE* read_pipe = fdopen(read_fd, "r");
        FILE* write_pipe = fdopen(write_fd, "w");
    #endif

    if (!read_pipe || !write_pipe) {
        std::cerr << "Failed to open pipes." << endl;
        return;
    }

    // Send the UCI command to engine
    fprintf(write_pipe, "uci\n");
    fflush(write_pipe);

    // Read and print engine's response
    char buffer[4096];
    while (fgets(buffer, sizeof(buffer), read_pipe)) {
        log("engine: " + string(buffer));
        if (strstr(buffer, "uciok")) {
            break;
        }
    }
    buffer[0] = '\0';



    // Setup some things needed for the game review
    std::string fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";
    game_data _data = read_pgn(game_path);

    // Defines eval variables responsible for keeping track of centipawn score
    int last_eval = 0;
    int eval = 0;
    int second_best_eval = 0;

    // Defines the variable info_list to be used to keep track of everything needed to send to the GUI
    vector<move_data> info_list;

    // Defines variables used to track the time and progress of the analyzer for the loading bar
    //float elapsed_time = 0;

    fprintf(write_pipe, "isready\n");
    fflush(write_pipe);

    while (fgets(buffer, sizeof(buffer), read_pipe)) {
        log("engine: " + string(buffer));
        if (strstr(buffer, "readyok")) {
            break;
        }
    }
    // Sets up the engine to mutipv 2
    fprintf(write_pipe, "setoption name MultiPV value 2\n");
    fflush(write_pipe);

    fprintf(write_pipe, "setoption name Threads value %d\n", threads);
    fflush(write_pipe);

    fprintf(write_pipe, "isready\n");
    fflush(write_pipe);

    while (fgets(buffer, sizeof(buffer), read_pipe)) {
        log("engine: " + string(buffer));
        if (strstr(buffer, "readyok")) {
            break;
        }
    }

    // Gives starting information to info_list
    info_list.emplace_back(move_data{"", 0, "", QString::fromStdString(fen), ""});

    // Creates a vector of std::strings to hold the output of the engine and the buffer
    vector<std::string> lines;

    // Creates a board object to track moves and attackers
    Board board;


    // Runs the engine
    fprintf(write_pipe, "go depth %d\n", depth);
    fflush(write_pipe);

    // Reads the engine's response and puts it into a vector of lines
    while (fgets(buffer, sizeof(buffer), read_pipe)) {
        log("engine: " + string(buffer));
        lines.push_back(buffer);
        if (strstr(buffer, "bestmove")) {
            break;
        }
    }
    // Interprets the engine's response and keeps necessary information
    std::string first_best_move;
    std::string second_best_move;
    // best_move_eval used for move type calculations
    int best_move_eval;

    // second_best_move_eval used specifically for Great Moves
    int second_best_move_eval;

    std::string pv1 = lines[lines.size() - 3];
    std::string pv2 = lines[lines.size() - 2];

    // Checks for forced moves.
    // When uci engines detect a forced move they omit the second pv.
    // Therefore the first pv comes on the second to last line.
    // If the move is forced we set the second_best_move to "forced" so we can use it to check later.
    if (strstr(pv2.c_str(), "multipv 1") == NULL) {
        first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
        second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
    }
    else {
        first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
        second_best_move = "forced";
    }
    best_move_eval = atoi(pv1.substr(pv1.find("cp") + 3, 2).c_str());
    second_best_move_eval = atoi(pv2.substr(pv2.find("cp") + 3, 2).c_str());

    last_eval = best_move_eval;

    // Tracks progress through the move list
    double counter = -1;
    
    std::string new_fen = board.getFen();

    // Loops through the moves in the game
    for (auto& qStrmove : _data.moves) {
        // Updates counter
        counter = counter + 1;
        // Updates the progress bar
        if (!QMetaObject::invokeMethod(qfuncs, "reportProgress", Qt::QueuedConnection, Q_ARG(int, (counter/(_data.moves.size())*100)))) {
            log("Failed to call loading screen method\n");
        }

        std::string move = qStrmove.toStdString();
        // Clears the vector of lines to reduce memory usage
        lines.clear();



        // Starts to determine the move type:
        // Brilliant, Great, Best, Excellent, Good, Innacurate, Mistake, Blunder
        std::string move_type;

        // Updates the board with the previous move
        board.setFen(fen);

        // parseSan function doesn't work with castling so we manually convert to Uci and then put it through uci::uciToMove
        if (move == "O-O" || move == "O-O-O") {

            // There are only 4 ways a castle can happen in a game of chess (both white and black can both short and long castle) so the conversion is simple
            Color turn = board.sideToMove();

            if (turn == Color::WHITE) {
                if (move == "O-O") {
                    move = "e1g1";
                    board.makeMove(uci::uciToMove(board, "e1g1"));
                }
                else {
                    move = "e1c1";
                    board.makeMove(uci::uciToMove(board, "e1c1"));
                }
            }
            else {
                if (move == "O-O") {
                    move = "e8g8";
                    board.makeMove(uci::uciToMove(board, "e8g8"));
                }
                else {
                    move = "e8c8";
                    board.makeMove(uci::uciToMove(board, "e8c8"));
                }
            }
        }
        else {
            Move san = uci::parseSan(board, move);
            std::string from = san.from();
            std::string to = san.to();
            move = from + to;
            board.makeMove(san);
        }

        // Gets the new fen for move type calculations
        new_fen = board.getFen();

        
        // Updates the position in the engine
        // This returns no output
        fprintf(write_pipe, "position fen %s\n", new_fen.c_str());
        fflush(write_pipe);

        fprintf(write_pipe, "isready\n");
        fflush(write_pipe);

        while (fgets(buffer, sizeof(buffer), read_pipe)) {
            log("engine: " + string(buffer));
            lines.push_back(buffer);
            if (strstr(buffer, "readyok") != NULL) {
                break;
            }
        }


        // Runs the engine
        fprintf(write_pipe, "go depth %d\n", depth);
        fflush(write_pipe);

        // Reads the engine output
        while (fgets(buffer, sizeof(buffer), read_pipe) != NULL) {
            log("engine: " + string(buffer));
            lines.push_back(buffer);
            if (strstr(buffer, "bestmove") != NULL) {
                break;
            }
        }
        // Store the integer centipawn values of the best and second best possible evaluations
        eval = atoi(lines[lines.size() - 3].substr(lines[lines.size() - 3].find("cp") + 2, 5).c_str());
        second_best_eval = atoi(lines[lines.size() - 2].substr(lines[lines.size() - 2].find("cp") + 2, 2).c_str());
        pv1 = lines[lines.size() - 3];
        pv2 = lines[lines.size() - 2];
        // Creates a lookup table for piece values
        values piece_values = {9, 5, 3, 3, 1};

        // Stores the change in evaluation between this move and the last
        int eval_change = eval - last_eval;

        // Gets the best possible change in evaluation
        // This is used to determine if the change in eval is because of further calculation or a bad move
        int best_eval_change = best_move_eval - last_eval;

        // If black played the move we flip the sign of these since a positive change is good for white but bad for black
        if (board.sideToMove() == Color::WHITE) {
            eval_change = -eval_change;
            best_eval_change = -best_eval_change;
        } else {
            eval = -eval;
        }

        // Starts with Best Great and Brilliant moves, which all require the best move to be played
        // Great Moves are when you play the only good move: second best move is minimum an innacurate move
        // Brilliant Moves are Best moves that sacrifice a piece
        if (move == first_best_move) {
            // Pulls the move_to square from the full move
            /*std::string move_to = move.substr(2, 2);

            // Gets a number of all attackers to the square
            vector<int> attackers = get_attackers(fen, move_to, board);
            // Checks to see if the other side is attacking the square more than you are
            if (attackers[0] > attackers[1]) {
                // Returns the move type as a Brilliant Move
                move_type = "Brilliant Move";
                fen = new_fen;
                info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
                last_eval = eval;

                // Updates the best and second best moves
                if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                    first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                    second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                }
                else {
                    first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                    second_best_move = "forced";
                }
                continue;
            }*/

            // Checks if the move was forced
            // If so nothing else is needed so we return
            if (second_best_move == "forced") {
                move_type = "Forced Move";
                fen = new_fen;
                info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
                last_eval = eval;
                continue;
            }

            // Checks to see if the best move is the only good move
            // First we need to find the relative eval change to account for engine error
            // We do this by subtracting the best eval change from the second best
            // Finally if the second best would be an inaccuracy or worse (<30 centipawns) we return a Great Move
            int second_best_eval_change = second_best_move_eval - last_eval;

            // Switch for white again
            if (board.sideToMove() == Color::WHITE) {
                second_best_eval_change = -second_best_eval_change;
            }

            if ((second_best_eval_change - best_eval_change) > 150) {
                best_move_eval = atoi(pv1.substr(pv1.find("cp") + 3, 2).c_str());
                second_best_move_eval = atoi(pv2.substr(pv2.find("cp") + 3, 2).c_str());
                move_type = "Great Move";
                fen = new_fen;
                info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
                last_eval = eval;

                // Updates the best and second best moves
                if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                    first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                    second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                }
                else {
                    first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                    second_best_move = "forced";
                }
                continue;
            }

            best_move_eval = atoi(pv1.substr(pv1.find("cp") + 3, 2).c_str());
            second_best_move_eval = atoi(pv2.substr(pv2.find("cp") + 3, 2).c_str());

            // Could be nothing else so we return with a Best Move
            move_type = "Best Move";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }

        // The rest of the checks are straightforward and just check the eval change minus the best eval change and compare it to the right numbers
        int relative_eval_change = abs(best_eval_change - eval_change);

        if (relative_eval_change < 30) {
            move_type = "Excellent Move";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }
        if (relative_eval_change < 150) {
            move_type = "Good Move";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }
        if (relative_eval_change < 300) {
            move_type = "Inaccuracy";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }
        if (relative_eval_change < 600) {
            move_type = "Mistake";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }
        if (relative_eval_change >= 600) {
            move_type = "Blunder";
            fen = new_fen;
            info_list.emplace_back(move_data{QString::fromStdString(first_best_move), eval, QString::fromStdString(move_type), QString::fromStdString(fen), QString::fromStdString(move)});
            last_eval = eval;

            // Updates the best and second best moves
            if (strstr(pv2.c_str(), "multipv 1") == NULL) {
                first_best_move = pv1.substr(pv1.find(" pv") + 4, 4);
                second_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
            }
            else {
                first_best_move = pv2.substr(pv2.find(" pv") + 4, 4);
                second_best_move = "forced";
            }
            continue;
        }
    }
    fclose(read_pipe);
    fclose(write_pipe);

    // Send finished signal to QML app
    QMetaObject::invokeMethod(qfuncs, "finished", Qt::QueuedConnection);

    data = {info_list, _data};
    emit finished();
}

void Analyzer::quit() {
    #ifdef _WIN32
        TerminateProcess(pi.hProcess, 0);
    #else
        kill(pid, SIGTERM);
    #endif
}

void Analyzer::setup_pipes() {

    #ifdef _WIN32
        HANDLE hChildStd_IN_Rd, hChildStd_IN_Wr;
        HANDLE hChildStd_OUT_Rd, hChildStd_OUT_Wr;

        SECURITY_ATTRIBUTES sa = { sizeof(SECURITY_ATTRIBUTES), NULL, TRUE };

        // Create pipes
        if (!CreatePipe(&hChildStd_OUT_Rd, &hChildStd_OUT_Wr, &sa, 0)) {
            cerr << "Failed to create stdout pipe.\n";
        }
        if (!CreatePipe(&hChildStd_IN_Rd, &hChildStd_IN_Wr, &sa, 0)) {
            cerr << "Failed to create stdin pipe.\n";
        }

        // Make sure the write handle to child's STDOUT is not inherited
        SetHandleInformation(hChildStd_OUT_Rd, HANDLE_FLAG_INHERIT, 0);
        SetHandleInformation(hChildStd_IN_Wr, HANDLE_FLAG_INHERIT, 0);

        STARTUPINFOA si = { sizeof(STARTUPINFO) };
        si.dwFlags |= STARTF_USESTDHANDLES;
        si.hStdInput = hChildStd_IN_Rd;
        si.hStdOutput = hChildStd_OUT_Wr;
        si.hStdError = GetStdHandle(STD_ERROR_HANDLE);

        std::string cmdline = engine_path;
        char cmdline_cstr[1024];
        strcpy_s(cmdline_cstr, cmdline.c_str());

        if (!CreateProcessA(NULL, cmdline_cstr, NULL, NULL, TRUE, CREATE_NO_WINDOW, NULL, NULL, &si, &this->pi)) {
            cerr << "Failed to create process: " << GetLastError() << endl;
        }

        // Close unused pipe ends
        CloseHandle(hChildStd_IN_Rd);
        CloseHandle(hChildStd_OUT_Wr);

        // Convert HANDLEs to file descriptors for compatibility with `analyze()`
        int read_fd = _open_osfhandle((intptr_t)hChildStd_OUT_Rd, _O_RDONLY);
        int write_fd = _open_osfhandle((intptr_t)hChildStd_IN_Wr, _O_WRONLY);

        analyze(read_fd, write_fd, engine_path, depth, game_path, threads);

        CloseHandle(this->pi.hProcess);
        CloseHandle(this->pi.hThread);
        CloseHandle(hChildStd_IN_Wr);
        CloseHandle(hChildStd_OUT_Rd);

    #else

        int pipe_to_engine[2];
        int pipe_from_engine[2];

        if (pipe(pipe_to_engine) == -1 || pipe(pipe_from_engine) == -1) {
            cerr << "Failed to create pipes." << endl;
        }

        pid = fork();
        if (pid == -1) {
            cerr << "Failed to fork." << endl;
        }

        if (pid == 0) {  // Child process
            // Redirect stdin and stdout to the pipes
            dup2(pipe_to_engine[0], STDIN_FILENO);
            dup2(pipe_from_engine[1], STDOUT_FILENO);

            // Close unused pipe ends
            close(pipe_to_engine[1]);
            close(pipe_from_engine[0]);

            // Execute the engine
            execlp(engine_path.c_str(), engine_path.c_str(), nullptr);

            // If execlp fails
            cerr << "Failed to execute the engine." << endl;
        } else {  // Parent process
            // Close unused pipe ends
            close(pipe_to_engine[0]);
            close(pipe_from_engine[1]);

            analyze(pipe_from_engine[0], pipe_to_engine[1], engine_path, depth, game_path, threads);

            // Close remaining pipe ends
            close(pipe_to_engine[1]);
            close(pipe_from_engine[0]);
        }
    #endif

}

game_data Analyzer::read_pgn(const std::string& f) {
    // Opens the pgn file
    ifstream file(f);

    // Creates an object of the PGNParser class
    PGNParser parse;

    // Creates a stream parser object
    pgn::StreamParser parser(file);

    // Reads the games
    parser.readGames(parse);

    file.close();

    game_data game = parse.game;
    return game;
}


vector<int> Analyzer::get_attackers(string fen, std::string targetSquare_string, Board &board) {
    // Converts the target square to a square object
    chess::Square targetSquare = chess::Square(targetSquare_string);

    // Creates variables to hold the number of attackers for each side
    int white_attackers = 0;
    int black_attackers = 0;

    // Gets a bitboard of white attackers then puts them into an integer
    chess::Bitboard attackers = chess::attacks::attackers(board, chess::Color("White"), targetSquare);
    int num_white_attackers = attackers.count();
    // Gets a bitboard of black attackers then puts them into an integer
    attackers = chess::attacks::attackers(board, chess::Color("Black"), targetSquare);
    int num_black_attackers = attackers.count();

    return {num_white_attackers, num_black_attackers};
}

PGNParser::~PGNParser() {}

void PGNParser::startPgn() {}

void PGNParser::header(std::string_view key, std::string_view value) {
    // Goes through and gets all the header information
    if (key == "Event") {
        game.event = QString::fromStdString(std::string(value));
    } else if (key == "Site") {
        game.site = QString::fromStdString(std::string(value));
    } else if (key == "Date") {
        game.date = QString::fromStdString(std::string(value));
    } else if (key == "Round") {
        game.round = QString::fromStdString(std::string(value));
    } else if (key == "White") {
        game.white = QString::fromStdString(std::string(value));
    } else if (key == "Black") {
        game.black = QString::fromStdString(std::string(value));
    } else if (key == "Result") {
        game.result = QString::fromStdString(std::string(value));
    }
}

void PGNParser::startMoves() {}

void PGNParser::move(std::string_view move, std::string_view comment) {
    // Adds the move to the moves vector
    game.moves.emplace_back(QString::fromStdString(std::string(move)));
}

void PGNParser::endPgn() {}
