#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QListWidgetItem>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:

    void on_EnginesList_itemDoubleClicked(QListWidgetItem *item);

    void on_pushButton_clicked();

    void on_GameList_itemDoubleClicked(QListWidgetItem *item);

    void on_Depth_returnPressed();

    void on_AddGame_clicked();

    void on_lineEdit_returnPressed();

private:
    Ui::MainWindow *ui;
    char engine[100];
    char game[100];
    char depth[100];
};
#endif // MAINWINDOW_H
