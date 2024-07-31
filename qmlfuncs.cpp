#include "qmlfuncs.h"
#include <QDebug>
#include <fstream>
#include <filesystem>
#ifdef _WIN32 || WIN64
    #include <windows.h>
    #include <tchar.h>
#else
    #include <unistd.h>
    #include <sys/types.h>
    #include <sys/wait.h>
#endif
Qmlfuncs::Qmlfuncs(QObject *parent)
    : QObject{parent}
{
    int x = 0;
}


void Qmlfuncs::addGame(QString pgn, QString name) {

#ifdef _WIN32 || WIN64
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
#ifdef _WIN32 || WIN64
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
#ifdef _WIN32 || WIN64
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
    #ifdef _WIN32 || _WIN64
        return "windows";
    #else
        return "other";
    #endif
}

void Qmlfuncs::runAnalyzer(QString game, QString engine, QString depth) {
    QString cmd;

#ifdef _WIN32 || _WIN64
    cmd = ".\\analyzer\\analyze.exe ";
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
#else

    int pid = fork();
    if (pid == 0) {
        // Child process
        char *eng = new char[engine.size() + 1];
        strncpy(eng, engine.toStdString().c_str(), engine.size());
        eng[engine.size()] = '\0';  // Ensure null termination
        char *dep = new char[depth.size() + 1];
        strncpy(dep, depth.toStdString().c_str(), depth.size());
        dep[depth.size()] = '\0'; 
        char *gam = new char[game.size() + 1];
        strncpy(gam, game.toStdString().c_str(), game.size());
        gam[game.size()] = '\0';

        execl("./analyzer/analyze", "./analyzer/analyze", eng, dep, gam, nullptr);
            
        // If execl fails
        perror("execl failed");
        delete[] eng;
        delete[] gam;
        exit(EXIT_FAILURE);  
    } else if (pid > 0) {
        int status;
        waitpid(pid, &status, 0);
    } else {
        printf("pid failed\n");
    }
    // Use a non-zero exit code to indicate failure
#endif

    
}

