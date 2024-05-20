# main.py
import sys
from PySide6.QtCore import QCoreApplication, QObject, Slot, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import game_review
import colorama
from bridge import Bridge

colorama.init()
           


if __name__ == '__main__':
    setup, game_stuff = game_review.get_game("./engines/stockfish-popcnt.exe", 12, "./games/test.pgn")
    app = QGuiApplication()
    engine = QQmlApplicationEngine()

    # Create an instance of the Bridge class and expose it to QML
    bridge = Bridge(setup, game_stuff)
    engine.rootContext().setContextProperty("bridge", bridge)

    # Get the path of the current directory and add the QML file name
    qml_file = 'analyzer/main.qml'
    engine.load(QUrl.fromLocalFile(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    

    sys.exit(app.exec())