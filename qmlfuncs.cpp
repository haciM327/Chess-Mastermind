#include "qmlfuncs.h"
#include <QDebug>
#include <fstream>
#include <filesystem>
#include <windows.h>
#include <tchar.h>
Qmlfuncs::Qmlfuncs(QObject *parent)
    : QObject{parent}
{
    int x = 0;
}


void Qmlfuncs::addGame(QString pgn, QString name) {

#ifdef _WIN32 || WIN64
    std::string path = ".\\analyzer\\games\\";
#else
    std::string path = "/usr/local/share/chess-mastermind/games/";
#endif

    path += name.toStdString().c_str();
    std::ofstream outfile (path);

    outfile << pgn.toStdString().c_str();

    outfile.close();

}

QList<QString> Qmlfuncs::getGames() {
    QString path;
#ifdef _WIN32 || WIN64
    path = ".\\games\\";
#else
    path = "/usr/local/share/chess-mastermind/games/";
#endif
    QList<QString> return_value;
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 8)));
    }
    return return_value;
}

QList<QString> Qmlfuncs::getEngines() {
    QString path;
#ifdef _WIN32 || WIN64
    path = ".\\engines\\";
#else
    path = "/usr/local/share/chess-mastermind/engines/";
#endif
    QList<QString> return_value;
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 10)));
    }
    return return_value;
}

void Qmlfuncs::runAnalyzer(QString game, QString engine, QString depth) {
    QString cmd;

#ifdef _WIN32 || _WIN64
    cmd = ".\\analyzer\\analyze.exe ";
#else
    cmd = "/usr/local/bin/analyze ";
#endif

    cmd += engine;
    cmd += " ";
    cmd += depth;
    cmd += " ";
    cmd += game;
    //std::system(cmd.toStdString().c_str());
    STARTUPINFOA si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );
    char *command = new char[cmd.toStdString().size() + 1]; //= {'\0'};
    strncpy(command, cmd.toStdString().c_str(), cmd.toStdString().size());
    // Start the child process.
    if( !CreateProcessA( NULL,   // No module name (use command line)
                       command,        // Command line
                       NULL,           // Process handle not inheritable
                       NULL,           // Thread handle not inheritable
                       FALSE,          // Set handle inheritance to FALSE
                       CREATE_NO_WINDOW,              // No creation flags
                       NULL,           // Use parent's environment block
                       NULL,           // Use parent's starting directory
                       &si,            // Pointer to STARTUPINFO structure
                       &pi )           // Pointer to PROCESS_INFORMATION structure
        )
    {
        printf( "CreateProcess failed (%d).\n", GetLastError() );
        return;
    }

    // Wait until child process exits.
    WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles.
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
}

