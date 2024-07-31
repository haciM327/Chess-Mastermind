import sys
from PySide6.QtCore import QCoreApplication, QObject, Slot, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import game_review
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
    # Create an instance of the Bridge class and expose it to QML
    bridge = Bridge(setup, game_stuff)
    engine.rootContext().setContextProperty("bridge", bridge)
    # Get the path of the current directory and add the QML file name
    qml_file = 'analyzer/main.qml'
    engine.load(QUrl.fromLocalFile(qml_file))
    if not engine.rootObjects():
        print("Failed to load QML file.")
        sys.exit(-1)
    
    
    exit_code = app.exec()  # Start the application event loop


    # Cleanup
    #del bridge
    # Exiting
    app.quit()
    #sys.exit(exit_code)
    os._exit(0)