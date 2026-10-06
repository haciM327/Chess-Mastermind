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

#include "Logger.hpp"

#include <ctime>
#include <fstream>
#include <iostream>

// Sets the filename to be the current data and time in mm-dd-yy-hh-mm-ss.txt
Logger::Logger() {
    const time_t timestamp = time(NULL); // Saves the timestamp
    const tm datetime = *localtime(&timestamp); // Converts the timestamp to a datetime using the local time

    char output[50]; // Saves the output of strftime in order to save it to filename
    strftime(output, 50, "%m-%d-%y-%H:%M:%S", &datetime);

    filename = output;
    filename = std::string("./logs/").append(filename).append(".log");
}

// Opens and creates the file that the Logger will be using throughout the runtime
bool Logger::openFile() {
    logFile.open(filename, std::ios_base::app);

    if (!logFile) {
        return false;
    }
    return true;
}

// Prints a message using cout and then records it in the log
void Logger::log(const std::string& message) {
    std::cout << message;
    logFile << message;
}

void Logger::closeFile() {
    logFile.close();
}

Logger::~Logger() {
    if (logFile.is_open()) {
        logFile.close();
    }
}
