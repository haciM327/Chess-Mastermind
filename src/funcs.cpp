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

#include <iostream>
#include <fstream>
#include <filesystem>
#include "../include/funcs.hpp"

using namespace std;
namespace fs = std::filesystem;

int open_file() {
    ofstream log_file("logfile.txt");

   if (!log_file) {
        return 1;
    }
    log_file << "";
    log_file.close();
    return 0;
}

// Logs output to both cout and log file
int log(string msg) {
    cout << msg;

    ofstream log_file("logfile.txt", std::ios_base::app);
    log_file << msg;
    log_file.close();

    return 0;
}

bool is_installed() {
    fs::path img_path = "./img";
    // 1. fs::exists checks if the path is there at all
    // 2. fs::is_directory ensures it is a folder, not a file
    if (fs::exists(img_path) && fs::is_directory(img_path)) {
        return false;
    } else {
        return true;
    }
}
