#include <iostream>

#ifndef LOG_HPP
#define LOG_HPP
// Opens new log file
int open_file();

// Logs output to both cout and log file
int log(std::string msg);

// Checks if the app is running installed or portably
bool is_installed();
#endif
