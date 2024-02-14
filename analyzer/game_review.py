import chess
import chess.pgn
import chess.engine
import sys

import display

def get_game(e,d,g):
    global os
    global game
    global engine
    global dep
    



    game = None

    os = sys.platform
    engine = chess.engine.SimpleEngine.popen_uci(e)
    dep = d
    file = g
    try:
        f = open(file, "r")
    except:
        print("ERROR: File could not be found!")
        sys.exit()

    try:
        game = chess.pgn.read_game(f)
    except:
        print("ERROR: Could not read PGN!")
        sys.exit()
    

    f.close()
    analyze(file)
    return 0
def analyze(f):
    global game
    board = chess.Board()
    moves = game.mainline_moves()
    move = 0
    player = chess.WHITE
    lasteval = 0
    cureval = 0
    info_list = []
    move_info_list = []
    for move in moves:
        eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=2)
        best_move = eval[0]["pv"][0]
        if len(eval) > 1:
            best_move2 = eval[1]["pv"][0]
        else:
            best_move2 = "forced"
        best_move = eval[0]["pv"][0]
        move_info_list.append(best_move)
        turn = board.turn
        board.push(move)
        #print(board)
        cureval = eval[0]["score"].pov(player)
        move_info_list.append(cureval)
        move_info_list.append(get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board))
        lasteval = cureval
        info_list.append(move_info_list)
        move_info_list = [] 
    try:
        display.main_loop(f, info_list)
    except Exception as e:
        print(e)
        input()
    close()


def get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board):
    cureval = cureval.__str__()
    lasteval = lasteval.__str__()
    if "#" in cureval:
        cureval = cureval.replace("#", "")
        cureval = cureval.replace("-", "")
        cureval = 1000000-int(cureval)
    if "#" in lasteval:
        lasteval = lasteval.replace("#", "")
        lasteval = lasteval.replace("-", "")
        lasteval = 1000000-int(lasteval)
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
                return "Brilliant Move!!"
            
            board.pop()
            board.push(best_move2)
            eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=1)
            if "#" in eval[0]["score"].pov(chess.WHITE).__str__():
                x = 1000000
            else:
                x = int(eval[0]["score"].pov(chess.WHITE).__str__())*2
            if x-int(eval[0]["score"].pov(chess.WHITE).__str__().replace("#", "").replace("-", "")) < lasteval:
                board.pop()
                board.push(best_move)
                return "Great Move!"
            board.pop()
            board.push(best_move)
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
        if eval_change >= -60:
            return "Inaccuracy!"

def close():
    engine.quit()
    sys.exit()
if __name__ == "__main__":
    get_game("./engines/stockfish.exe", 1, "./games/example.pgn")

