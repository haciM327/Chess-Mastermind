from PySide6 import QtCore

class funcs(QtCore.QObject):
    def __init__(self, *args, **kwags):
        QtCore.QObject.__init__(self, *args, **kwags)

    @QtCore.Slot()  
    def test():
        return "Test"