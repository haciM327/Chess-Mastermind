import chess
import chess.pgn
import chess.engine
import sys
import colorama
import time


def get_game():
    global os
    global game
    global engine
    global dep
    
    colorama.init(autoreset=True)


    game = None

    os = sys.platform
    engine = chess.engine.SimpleEngine.popen_uci(input("Enter engine path: "))
    dep = int(input("Enter the depth of the engine: "))
    file = input("Please input your filename: ")
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
    analyze()
    return "1"
def analyze():
    global game
    board = chess.Board()
    moves = game.mainline_moves()
    move = 0
    player = chess.WHITE
    lasteval = 0
    cureval = 0
    for move in moves:
        eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=2)
        best_move = eval[0]["pv"][0]
        if len(eval) > 1:
            best_move2 = eval[1]["pv"][0]
        else:
            best_move2 = "forced"
        best_move = eval[0]["pv"][0]
        print(best_move)
        turn = board.turn
        board.push(move)
        print(board)
        cureval = eval[0]["score"].pov(player)
        print(cureval)
        print(get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board))
        lasteval = cureval
        input()

def get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board):
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
            
            board.pop()
            board.push(best_move2)
            eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=1)
            if int(eval[0]["score"].pov(chess.WHITE).__str__()) < lasteval:
                board.pop()
                board.push(best_move)
                return colorama.Fore.LIGHTCYAN_EX + "Great Move!"
            board.pop()
            board.push(best_move)
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

def close():
    engine.quit()
    sys.exit()
if __name__ == "__main__":
    get_game()

