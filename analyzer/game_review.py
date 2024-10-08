import chess
import chess.pgn
import chess.engine
import sys
import time

def get_game(e, d, g):
    global os
    global game
    global engine
    global dep


    os = sys.platform
    engine = chess.engine.SimpleEngine.popen_uci(e)
    dep = d
    file = g
    f = open(file, "r")
    game = chess.pgn.read_game(f)


    f.close()
    analyze_return = analyze(file)
    return True, analyze_return


def analyze(f):
    global game
    board = chess.Board()
    mainline_moves = game.mainline_moves() # type: ignore
    move = 0
    player = chess.WHITE
    lasteval = 0
    cureval = 0
    info_list = []
    move_info_list = []
    elapsed = []
    times = []
    moves = []
    for i in mainline_moves:
        moves.append(i)
    eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=2)
    info_list.append(['', eval[0]["score"].pov(player).__str__(), "", board.fen().__str__()]) # type: ignore
    for move in moves:

        print(move)
        print(board)

        times.append(time.time())
        try:
            eval = engine.analyse(board, chess.engine.Limit(depth=dep), multipv=2)
        except:
            print("The engine has terminated unexpectedly")
            break

        best_move = eval[0]["pv"][0]

        if len(eval) > 1:
            best_move2 = eval[1]["pv"][0] # type: ignore
        else:
            best_move2 = "forced"

        move_info_list.append(best_move.__str__())
        turn = board.turn
        board.push(move)

        cureval = eval[0]["score"].pov(player)

        move_info_list.append(cureval.__str__())
        move_info_list.append(get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board))
        move_info_list.append(board.fen())
        move_info_list.append(move.uci().__str__())

        lasteval = cureval
        info_list.append(move_info_list)
        move_info_list = []

        times.append(time.time())
        elapsed.append(times[1]-times[0])

        print(f"{(1+moves.index(move))/len(moves)*100:.2f}% complete!")
        print(f"About {get_time(elapsed, moves, move)}until completed!")

        times = []

    engine.quit()
    return f, info_list



def get_move_type(turn, cureval, lasteval, move, best_move, best_move2, eval, board):
    if best_move2 == 'forced':
        return best_move2
    values = {
        chess.QUEEN: 9,
        chess.ROOK: 5,
        chess.BISHOP: 3,
        chess.KNIGHT: 3,
        chess.PAWN: 1 }
    cureval = cureval.__str__()
    lasteval = lasteval.__str__()
    if '#' in cureval:
        cureval = cureval.replace('#', '')
        cureval = cureval.replace('-', '')
        cureval = 1000000 - int(cureval)
    if '#' in lasteval:
        lasteval = lasteval.replace('#', '')
        lasteval = lasteval.replace('-', '')
        lasteval = 1000000 - int(lasteval)
    print(cureval)
    cureval = int(cureval)
    lasteval = int(lasteval)
    opturn = chess.BLACK
    eval_change = cureval - lasteval
    popped = False
    best_eval_change = get_best_eval(board, best_move, turn, move) - lasteval
    if move == best_move:
        if len(board.attackers(opturn, move.to_square)) > len(board.attackers(turn, move.to_square)):
            piece_type = board.piece_type_at(move.to_square)
            if not piece_type == chess.PAWN:
                board.pop()
                popped = True
                if board.is_capture(move) or values[piece_type] < values[board.piece_type_at(move.to_square)]:
                    board.push(best_move)
                    return 'Brilliant Move!!'
        if not popped:
            board.pop()
        board.push(best_move2)
        eval = engine.analyse(board, chess.engine.Limit(depth = dep), multipv = 1)
        if '#' in eval[0]['score'].pov(chess.WHITE).__str__():
            x = 1000000
        else:
            x = int(eval[0]['score'].pov(chess.WHITE).__str__()) * 2
        if x - int(eval[0]['score'].pov(chess.WHITE).__str__().replace('#', '').replace('-', '')) - lasteval - best_eval_change > 40:
            board.pop()
            board.push(best_move)
            return 'Great Move!'
        board.pop()
        board.push(best_move)
        return 'Best Move!'
    if eval_change - best_eval_change < 10:
        return 'Excellent Move!'
    if eval_change - best_eval_change < 20:
        return 'Good Move!'
    if eval_change - best_eval_change < 30:
        return 'Inaccuracy!'
    if eval_change - best_eval_change < 40:
        return 'Mistake!'
    if eval_change - best_eval_change >= 40:
        return 'Blunderous Move!'


def get_time(elapsed, moves, move):
    return_value = ''
    avg_sec = (sum(elapsed) / len(elapsed)) * (len(moves) - moves.index(move))
    if avg_sec > 60:
        avg_min = avg_sec / 60
        avg_sec = avg_sec % 60
        return_value += f'''{int(avg_sec)} seconds '''
        if avg_min > 60:
            avg_hour = avg_min / 60
            avg_min = avg_min % 60
            return_value = f'''{int(avg_min)} minutes ''' + return_value
            if avg_hour > 24:
                avg_day = avg_hour / 24
                avg_hour = avg_hour % 24
                return_value = f'''{int(avg_hour)} hours ''' + return_value
                return_value = f'''{int(avg_day)} days ''' + return_value
                return return_value
            return_value = f'''{int(avg_hour)} hours ''' + return_value
            return return_value
        return_value = f'''{int(avg_min)} minutes ''' + return_value
        return return_value
    return_value += f'''{int(avg_sec)} seconds '''
    return return_value


def get_best_eval(board, best_move, player, move):
    board.pop()
    board.push(best_move)
    ret = engine.analyse(board, chess.engine.Limit(depth = dep), multipv = 1)[0]['score'].pov(player).__str__()
    board.pop()
    board.push(move)
    if '#' in ret:
        ret = ret.replace('#', '')
        ret = ret.replace('-', '')
        ret = 1000000 - int(ret)
    if player == chess.BLACK:
        ret = -int(ret)
    return int(ret)


def close():
    engine.quit()
    sys.exit()

