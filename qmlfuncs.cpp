#include "qmlfuncs.h"
#include <QDebug>
#include <fstream>
#include <filesystem>
#include <dirent.h>
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


 
bool Qmlfuncs::getport()
{
 
    DIR *pDir;
    bool bExists = false;
 
    pDir = opendir ("../share");
 
    if (pDir != NULL)
    {
        bExists = true;
        port = true;    
        (void) closedir (pDir);
    }

    return bExists;
}
void Qmlfuncs::addGame(QString pgn, QString name) {
std::string path;
#ifdef _WIN32 || WIN64
    std::string path = ".\\analyzer\\games\\";
#else
    if (port) {
        std::string path = "../share/chess-mastermind/games";
    } else {
        std::string path = "/usr/local/share/chess-mastermind/games";
    }
#endif

    path += name.toStdString().c_str();
    std::ofstream outfile (path);

    outfile << pgn.toStdString().c_str();

    outfile.close();

}

QList<QString> Qmlfuncs::getGames() {
    QString path;
    QList<QString> return_value;
#ifdef _WIN32 || WIN64
    path = ".\\games\\";
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 8)));
    }
#else
    if (port) {
        path = "../share/chess-mastermind/games";
        for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
            return_value.append(QString::fromStdString(entry.path().string().erase(0, 32)));
        }
    } else {
        path = "/usr/local/share/chess-mastermind/games";
        for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
            return_value.append(QString::fromStdString(entry.path().string().erase(0, 42)));
        }
    }
#endif
    
    
    return return_value;
}

QList<QString> Qmlfuncs::getEngines() {
    QString path;
    QList<QString> return_value;
#ifdef _WIN32 || WIN64
    path = ".\\engines\\";
    for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
        return_value.append(QString::fromStdString(entry.path().string().erase(0, 10)));
    }
#else
    if (port) {
        path = "../share/chess-mastermind/engines/";
        for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
            return_value.append(QString::fromStdString(entry.path().string().erase(0, 34)));
        }
    } else {
        path = "/usr/local/share/chess-mastermind/engines/";
        for (const auto & entry : std::filesystem::directory_iterator(path.toStdString())) {
            return_value.append(QString::fromStdString(entry.path().string().erase(0, 44)));
        }
    }
#endif
    
    
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
    cmd += " true";
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
        if (port) {
            execl("./analyze", "./analyze", eng, dep, gam, "true", nullptr);
        } else {
            execl("/usr/local/bin/analyze", "/usr/local/bin/analyze", eng, dep, gam, "false", nullptr);
        }
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

