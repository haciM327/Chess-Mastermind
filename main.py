import chess
import chess.pgn
import chess.engine
import sys

game = None

os = sys.platform

if os == "win32":
    engine = chess.engine.SimpleEngine.popen_uci("./stockfish/stockfish-windows-x86-64-modern.exe")
elif os == "darwin":
    engine = chess.engine.SimpleEngine.popen_uci("./stockfish/stockfish-macos-x86-64-modern")
elif os == "linux":
    engine = chess.engine.SimpleEngine.popen_uci("./stockfish/stockfish-ubuntu-x86-64-modern")
else:
    print("ERROR: Your operating system is not supported!")

def get_game():
    global game
    file = input("Please input your filename: ") + ".chess"
    try:
        f = open(file, "r")
    except:
        print("ERROR: File could not be found!")
        quit()

    try:
        game = chess.pgn.read_game(f)
    except:
        print("ERROR: Could not read PGN!")
    

    f.close()
def analyze():
    global game
    board = chess.Board()
    print(game)
    moves = game.mainline_moves()
    move = 0
    player = chess.WHITE
    lasteval = 0
    cureval = 0
    for move in moves:
        eval = engine.analyse(board, chess.engine.Limit(depth=10))
        best_move = eval["pv"][0]
        print(best_move)
        turn = board.turn
        board.push(move)
        print(board)
        cureval = eval["score"].pov(player)

        print(cureval)
        print(get_move_type(turn, cureval, lasteval, move, best_move))
        lasteval = cureval
        input()

def get_move_type(turn, cureval, lasteval, move, best_move):
    if turn == chess.BLACK:
        cureval = -cureval
        lasteval = -lasteval
    eval_change = (int(cureval.__str__()) - int(lasteval.__str__()))
    
    if eval_change >= 0:
        if move == best_move:
            return "Best Move!"
        if eval_change > 40:
            return "Excellent Move!"
        if eval_change < 40:
            return "Good Move!"
        
    else:
        if eval_change < -100:
            return "Blunderous Move!"
        if eval_change < -60:
            return "Mistake!"
        if eval_change > -60:
            return "Inaccuracy!"

get_game()
analyze()

engine.quit()
sys.exit()
quit()


