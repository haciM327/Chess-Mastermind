from PySide6.QtCore import QCoreApplication, QObject, Slot, QUrl
import colorama
class Bridge(QObject):

    def __init__(self, setup, game_stuff, parent=None):
        super(Bridge, self).__init__(parent)
        self.setup = setup
        self.game_stuff = game_stuff
        self.current_move = 0
        self.fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

    @Slot(result=bool)
    def load(self):
       return self.setup
    
    @Slot(str)
    def error(self, error):
        print(colorama.Fore.RED + error)

    @Slot(result=str)
    def get_fen(self):
        return self.fen
    
    @Slot(result=list)
    def move_ahead(self):
        self.current_move += 1
        if len(self.game_stuff[1]) == self.current_move:
            self.current_move -= 1
        self.fen = self.game_stuff[1][self.current_move][3]
        return self.game_stuff[1][self.current_move]
    @Slot(result=list)
    def move_back(self):
        self.current_move -= 1
        if 0 > self.current_move:
            self.current_move += 1
        self.fen = self.game_stuff[1][self.current_move][3]
        return self.game_stuff[1][self.current_move]
    
    @Slot(result=int)
    def get_move_number(self):
        return self.current_move
