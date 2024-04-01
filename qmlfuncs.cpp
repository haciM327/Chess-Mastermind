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
    std::string path = ".\\games\\";
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
    //MainWindow::hide();
    std::system(cmd.toStdString().c_str());
    //STARTUPINFO si;
    //PROCESS_INFORMATION pi;
    //const std::wstring wlpstrstd = cmd.toStdWString();
    //const wchar_t* lpcwStr = wlpstrstd.c_str(); // No need for LPCWSTR

    //if (!CreateProcess(NULL, lpcwStr, NULL, NULL, false, 0, NULL, NULL, &si, &pi))
    //{
    //    printf("CreateProcess failed (%d).\n", GetLastError());
    //    return;
    //}

    // Wait until child process exits.
    //WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles.
    //CloseHandle( pi.hProcess );
    //CloseHandle( pi.hThread );
}

