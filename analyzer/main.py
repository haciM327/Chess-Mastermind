# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import game_review

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    f, info_list = game_review.get_game("C:\\Users\\Micah\\Documents\\GitHub\\Chess-Mastermind\\engines\\stockfish.exe", 1, "../games/example.pgn")
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
