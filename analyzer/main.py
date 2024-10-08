import sys
from PySide6.QtCore import QCoreApplication, QObject, Slot, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
try:
    import game_review
except Exception as e:
    print(f"Error importing game_review: {e}")
import colorama
from bridge import Bridge
import threading
import time
import os
colorama.init()
if __name__ == '__main__':
    setup, game_stuff = game_review.get_game(sys.argv[1], int(sys.argv[2]), sys.argv[3])
    app = QGuiApplication()
    engine = QQmlApplicationEngine()
    bridge = Bridge(setup, game_stuff, sys.argv[4], game_review.game.headers)
    engine.rootContext().setContextProperty('bridge', bridge)
    if sys.argv[4] == 'true':
        qml_file = '../share/chess-mastermind/analyzer.qml'
    else:
        qml_file = '/usr/local/share/chess-mastermind/analyzer.qml'
    engine.load(QUrl.fromLocalFile(qml_file))
    if not engine.rootObjects():
        print('Failed to load QML file.')
        sys.exit(-1)
    sys.exit(app.exec())
