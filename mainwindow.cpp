#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <qdebug.h>
#include <QtGlobal>
#include <bits/stdc++.h>
#include <Windows.h>
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
    std::string path = ".\\engines";
    for (const auto & entry : std::filesystem::recursive_directory_iterator(path)) {
        //std::cout << entry.path() << std::endl;
        //std::cout << "hi\n";
        engine = entry.path().string();
        ui->EnginesList->addItem(QString::fromStdString(engine));
    }
    std::string game;
    path = ".\\games";
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
    cmd = "analyzer\\analyze.exe ";
    cmd += MainWindow::engine;
    cmd += " ";
    cmd += MainWindow::depth;
    cmd += " ";
    cmd += MainWindow::game;
    MainWindow::hide();
    std::system(cmd.c_str());
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
    std::string path = "./Games/";
    path += ui->lineEdit->text().toStdString().c_str();
    std::cout << path;
    std::ofstream outfile (path);

    outfile << ui->plainTextEdit->toPlainText().toStdString().c_str();

    outfile.close();

    ui->AddGame->show();
    ui->lineEdit->hide();
    ui->plainTextEdit->hide();
    ui->pushButton->show();
}

