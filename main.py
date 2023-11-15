import chess
import chess.pgn
import chess.engine
import sys
import colorama
import time

colorama.init(autoreset=True)


game = None

os = sys.platform
engine = chess.engine.SimpleEngine.popen_uci(input("Enter engine path: "))
dep = input("Enter the depth of the engine: ")

def get_game():
    global game
    file = input("Please input your filename: ") + ".pgn"
    try:
        f = open(file, "r")
    except:
        print(colorama.Fore.RED + "ERROR: File could not be found!")
        sys.exit()

    try:
        game = chess.pgn.read_game(f)
    except:
        print(colorama.Fore.RED + "ERROR: Could not read PGN!")
        sys.exit()
    

    f.close()
def analyze():
    global game
    board = chess.Board()
    moves = game.mainline_moves()
    move = 0
    player = chess.WHITE
    lasteval = 0
    cureval = 0
    for move in moves:
        eval = engine.analyse(board, chess.engine.Limit(depth=dep))
        best_move = eval["pv"][0]
        print(best_move)
        turn = board.turn
        board.push(move)
        print(board)
        cureval = eval["score"].pov(player)
        print(cureval)
        print(get_move_type(turn, cureval, lasteval, move, best_move, eval, board))
        lasteval = cureval
        input()

def get_move_type(turn, cureval, lasteval, move, best_move, eval, board):
    cureval = cureval.__str__()
    lasteval = lasteval.__str__()
    if "#" in cureval:
        cureval = cureval.replace("#", "")
    if "#" in lasteval:
        lasteval = lasteval.replace("#", "")
    cureval = int(cureval)
    lasteval = int(lasteval)
    opturn = chess.BLACK
    if turn == chess.BLACK:
        cureval = -cureval
        lasteval = -lasteval
        opturn = chess.WHITE
    eval_change = (cureval - lasteval)
    
    if eval_change >= 0:
        if move == best_move:
            if len(board.attackers(opturn, move.to_square)) > len(board.attackers(turn, move.to_square)):
                return colorama.Fore.CYAN + "Brilliant Move!!"
            
            #board.pop()
            #board.push(eval["pv"][1])
            #eval = engine.analyse(board, chess.engine.Limit(depth=dep))
            #if int(eval["score"].pov(turn).__str__()) < cureval:
                #return colorama.Fore.LIGHTCYAN_EX + "Great Move!"
            return colorama.Fore.LIGHTGREEN_EX + "Best Move!"
        if eval_change > 40:
            return colorama.Fore.GREEN + "Excellent Move!"
        if eval_change < 40:
            return "Good Move!"
        
    else:
        if eval_change < -100:
            return colorama.Fore.RED + "Blunderous Move!"
        if eval_change < -60:
            return colorama.Fore.LIGHTRED_EX + "Mistake!"
        if eval_change >= -60:
            return colorama.Fore.YELLOW + "Inaccuracy!"

get_game()
analyze()

engine.quit()
sys.exit()
quit()


