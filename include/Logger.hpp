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

#ifndef LOGGER_HPP
#define LOGGER_HPP
#include <fstream>
#include <string>

class Logger
{
public:
    Logger();

    ~Logger();

    // Opens a file for logging
    [[nodiscard]] bool openFile();

    // Logs output to both cout and log file
    void log(const std::string& message);

    void closeFile();

private:
    // Stores the log file name
    std::string filename;
    std::ofstream logFile;
};

#endif //LOGGER_HPP
