#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <qdebug.h>
#include <QtGlobal>
#include <bits/stdc++.h>
#include <filesystem>
#include <fstream>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->EnginesList->hide();
    ui->GameList->hide();
    ui->Depth->hide();
    ui->lineEdit->hide();
    ui->plainTextEdit->hide();
    std::string engine;
    #ifdef _WIN32 || WIN64
        std::string path = "./engines";
    #else
        std::string path = "/usr/local/share/chess-mastermind/engines";
    #endif
    for (const auto & entry : std::filesystem::recursive_directory_iterator(path)) {
        //std::cout << entry.path() << std::endl;
        //std::cout << "hi\n";
        engine = entry.path().string();
        ui->EnginesList->addItem(QString::fromStdString(engine));
    }
    std::string game;
    #ifdef _WIN32 || WIN64
        path = "./games";
    #else
        path = "/usr/local/share/chess-mastermind/games";
    #endif
    for (const auto & entry : std::filesystem::directory_iterator(path)) {
        game = entry.path().string();
        ui->GameList->addItem(QString::fromStdString(game));
    }


}

MainWindow::~MainWindow()
{
    delete ui;
}




void MainWindow::on_EnginesList_itemDoubleClicked(QListWidgetItem *item)
{
    strcpy(MainWindow::engine, item->text().toStdString().c_str());
    ui->EnginesList->hide();
    ui->GameList->show();



}


void MainWindow::on_pushButton_clicked()
{
    ui->EnginesList->show();
    ui->pushButton->hide();
    ui->AddGame->hide();
}


void MainWindow::on_GameList_itemDoubleClicked(QListWidgetItem *item)
{
    strcpy(MainWindow::game, item->text().toStdString().c_str());
    ui->GameList->hide();
    ui->Depth->show();

}


void MainWindow::on_Depth_returnPressed()
{
    strcpy(MainWindow::depth, ui->Depth->text().toStdString().c_str());
    ui->Depth->hide();
    std::string cmd;
    #ifdef _WIN32 || _WIN64
        cmd = "analyzer/analyze.exe ";
    #else
        cmd = "/usr/local/bin/analyze ";
    #endif
    cmd += MainWindow::engine;
    cmd += " ";
    cmd += MainWindow::depth;
    cmd += " ";
    cmd += MainWindow::game;
    MainWindow::hide();
    std::system(cmd.c_str());
    ui->pushButton->show();
    ui->AddGame->show();
    MainWindow::show();
}


void MainWindow::on_AddGame_clicked()
{
    ui->AddGame->hide();
    ui->pushButton->hide();
    ui->lineEdit->show();
    ui->plainTextEdit->show();

}

void MainWindow::on_lineEdit_returnPressed()
{
    #ifdef _WIN32 || WIN64
        std::string path = "./games";
    #else
        std::string path = "/usr/local/share/chess-mastermind/games";
    #endif
    path += ui->lineEdit->text().toStdString().c_str();
    std::ofstream outfile (path);

    outfile << ui->plainTextEdit->toPlainText().toStdString().c_str();

    outfile.close();

    std::string game;
    ui->GameList->clear();
    for (const auto & entry : std::filesystem::directory_iterator(path)) {
        game = entry.path().string();
        ui->GameList->addItem(QString::fromStdString(game));
    }
    ui->AddGame->show();
    ui->lineEdit->hide();
    ui->plainTextEdit->hide();
    ui->pushButton->show();
}

