#include <iostream>
#include <fstream>
#include "../include/funcs.hpp"

using namespace std;

int open_file() {
    ofstream log_file("logfile.txt");

    if (!log_file) {return 1;}

    log_file << "";
    log_file.close();
}

// Logs output to both cout and log file
int log(string msg) {
    cout << msg;

    ofstream log_file("logfile.txt", std::ios_base::app);
    log_file << msg;
    log_file.close();

    return 0;
}
