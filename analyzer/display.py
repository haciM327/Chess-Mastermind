# List of imports needed
import os
# Removes ugly pygame support text
os.environ['PYGAME_HIDE_SUPPORT_PROMPT'] = "hide"
import pygame
import pieces
import chess
import chess.pgn
import sys

# Defines the global list of pieces
global piece_list

# Initializes pygame so drawing will work
pygame.init()

# A function to automate drawing the board squares and the coordinates
def draw_board(move_type, square, cmove):
    
    # Draws the board squares to the board surface
    GREEN = pygame.Color(119,153,84)
    WHITE = pygame.Color(233,237,204)
    board = pygame.Surface((620, 620))
    for i in range(8):
        for j in range(8):
            if (i+j) % 2 == 0:
                color = WHITE
            else:
                color = GREEN
            pygame.draw.rect(board, color, (j*75, 20+i*75, 75, 75))
    
    # Defines variables for the coordinates
    BLACK = pygame.Color(0,0,0)
    font = pygame.font.SysFont("Ariel", 25)
    
    
    key = ['8','7','6','5','4','3','2','1']
    img = pygame.image.load("./img/placeholder.png")
    if move_type == "Mistake!":
        img = pygame.image.load("./img/mistake.png")
    if move_type == "Inaccuracy!":
        img = pygame.image.load("./img/innacuracy.png")
    if move_type == "Blunderous Move!":
        img = pygame.image.load("./img/blunder.png")
    if move_type == "Good Move!":
        img = pygame.image.load("./img/good.png")
    if move_type == "Excellent Move!":
        img = pygame.image.load("./img/excellent.png")
    if move_type == "Best Move!":
        img = pygame.image.load("./img/best.png")
    if move_type == "Great Move!":
        img = pygame.image.load("./img/great.png")
    if move_type == "Brilliant Move!!":
        img = pygame.image.load("./img/brilliant.png")
    img = pygame.transform.smoothscale(img, (30,30))
    if cmove > -1:
        board.blit(img, ((int(square[0])*75)+65, (int(key.index(square[1]))*75)+5))
    # Draws coordinates to the board surface
    board.blit(font.render("A", 1, BLACK), (60, 605))
    board.blit(font.render("B", 1, BLACK), (135, 605))
    board.blit(font.render("C", 1, BLACK), (210, 605))
    board.blit(font.render("D", 1, BLACK), (285, 605))
    board.blit(font.render("E", 1, BLACK), (360, 605))
    board.blit(font.render("F", 1, BLACK), (435, 605))
    board.blit(font.render("G", 1, BLACK), (510, 605))
    board.blit(font.render("H", 1, BLACK), (585, 605))
    board.blit(font.render("1", 1, BLACK), (2, 547))
    board.blit(font.render("2", 1, BLACK), (2, 472))
    board.blit(font.render("3", 1, BLACK), (2, 397))
    board.blit(font.render("4", 1, BLACK), (2, 322))
    board.blit(font.render("5", 1, BLACK), (2, 247))
    board.blit(font.render("6", 1, BLACK), (2, 172))
    board.blit(font.render("7", 1, BLACK), (2, 97))
    board.blit(font.render("8", 1, BLACK), (2, 22))



    return board

# A function to load a game based on the file

def load_game(file):
    # Opens the game and reads it
    pgn = open(file)
    game = chess.pgn.read_game(pgn)
    pgn.close()
    # Extracts necesary information
    headers = game.headers
    moves = game.mainline_moves()
    move = []
    # Converts chess moves to strings to simplify things later
    for m in moves:
        move.append(m.uci().__str__())
    
    moves = move
    return moves, headers

# A function to setup the game
def setup_game(headers):
    # Creates a key to convert from alpha-coordinates to numerical coordinates
    key = ["A","B","C","D","E","F","G","H"]
    # Adds all the pieces to the piece list
    piece_list = [pieces.piece("r", ["A", "1"], (7.5, 27.5+(75*7)), "./img/white_rook.png"),
                pieces.piece("n", ["B", "1"], (7.5+(75*1),27.5+(75*7)), "./img/white_knight.png"),
                pieces.piece("b", ["C", "1"], (7.5+(75*2), 27.5+(75*7)), "./img/white_bishop.png"),
                pieces.piece("q", ["D", "1"], (7.5+(75*3), 27.5+(75*7)), "./img/white_queen.png"),
                pieces.piece("k", ["E", "1"], (7.5+(75*4), 27.5+(75*7)), "./img/white_king.png"),
                pieces.piece("b", ["F", "1"], (7.5+(75*5), 27.5+(75*7)), "./img/white_bishop.png"),
                pieces.piece("n", ["G", "1"], (7.5+(75*6), 27.5+(75*7)), "./img/white_knight.png"),
                pieces.piece("r", ["H", "1"], (7.5+(75*7), 27.5+(75*7)), "./img/white_rook.png"),
                pieces.piece("R", ["A", "8"], (7.5+(75*0), 27.5+(75*0)), "./img/black_rook.png"),
                pieces.piece("N", ["B", "8"], (7.5+(75*1), 27.5+(75*0)), "./img/black_knight.png"),
                pieces.piece("B", ["C", "8"], (7.5+(75*2), 27.5+(75*0)), "./img/black_bishop.png"),
                pieces.piece("Q", ["D", "8"], (7.5+(75*3), 27.5+(75*0)), "./img/black_queen.png"),
                pieces.piece("K", ["E", "8"], (7.5+(75*4), 27.5+(75*0)), "./img/black_king.png"),
                pieces.piece("B", ["F", "8"], (7.5+(75*5), 27.5+(75*0)), "./img/black_bishop.png"),
                pieces.piece("N", ["G", "8"], (7.5+(75*6), 27.5+(75*0)), "./img/black_knight.png"),
                pieces.piece("R", ["H", "8"], (7.5+(75*7), 27.5+(75*0)), "./img/black_rook.png")]

    # Two loops for the all the pawns
    for i in range(8):
        piece_list.append(pieces.piece("p", [key[i], "2"], (7.5+(75*i), 27.5+(75*6)), "./img/white_pawn.png"))
    
    for i in range(8):
        piece_list.append(pieces.piece("P", [key[i], "7"], (7.5+(75*i), 27.5+(75*1)), "./img/black_pawn.png"))

    # Draws the player tags
    font = pygame.font.SysFont("Ariel", 25)
    ui = pygame.Surface((1280,720))
    WHITE = pygame.Color((255,255,255))
    ui.blit(font.render(headers["White"], 1, WHITE), (340,705))
    ui.blit(font.render(headers["Black"], 1, WHITE), (340,40))
    return piece_list, ui

# A function for moving ahead in the game
def move_ahead(move, piece_list, capture_list):
    # Defines pos and dest which is the square moving from (pos) and the square moving to (dest(ination))
    pos = move[:2].upper()
    dest = move[-2:].upper()
    # Defines the key again
    key = ["A", "B", "C", "D", "E", "F", "G", "H"]
    # Capture is a variable to determine whether or not a piece is captured
    capture = False
    # Filter through the pieces...
    for i in piece_list:
        # to find which piece is on the pos square...
        if i.coordinates == list(pos):
            # checks to move rook when castling...
            if i.type == "k" or i.type == "K":
                # gets the number of squares the king is moving...
                num = key.index(list(dest)[0]) - key.index(i.coordinates[0])
                # checks to see if the king moved 2 squares...
                if num == 2 or num == -2:
                    # filters through the piece list again...
                    for j in piece_list:
                        # finds the rooks...
                        if (j.type == "R" or j.type == "r") and (i.type.isupper() == j.type.isupper()):
                            # checks for direction the king is moving and makes sure it is the correct rook
                            if num == 2 and j.coordinates[0] == "H":
                                # moves the rook
                                j.move(key[key.index(list(dest)[0])-1], i.coordinates[1])
                            elif num == -2 and j.coordinates[0] == "A":
                                j.move(key[key.index(list(dest)[0])+1], i.coordinates[1])
            # moves the piece
            i.move(list(move)[2], list(move)[3])
        # checks for captures
        elif i.coordinates == list(dest):
            # adds the captured piece to the captured list to be reffered to later
            capture_list.append(i)
            # removes the captured piece from the piece list
            del piece_list[piece_list.index(i)]
            capture = True
    # checks if a piece was captured
    if not capture:
        # adds essentially a null value to give this move a place in the capture_list even if no piece was captured
        capture_list.append("0")
    return capture_list, piece_list

# A function to move back in the game
def move_back(move, piece_list, capture_list):
    # Defines pos and dest but this time pos is the travel square since everything is backwards
    pos = move[:2].upper()
    dest = move[-2:].upper()
    # key
    key = ["A", "B", "C", "D", "E", "F", "G", "H"]
    # If a piece was captured on this turn it adds it back
    if capture_list[-1] != "0":
        piece_list.append(capture_list[-1])

    # Filters the piece_list...
    for i in piece_list:
        # to find a piece on the dest square
        if i.coordinates == list(dest):
            # Checks for castling...
            if i.type == "k" or i.type == "K":
                # Finds the number of squares the king moved
                num = key.index(list(pos)[0]) - key.index(i.coordinates[0])
                # checks if the king moved two squares
                if num == 2 or num == -2:
                    # filters through the piece list again
                    for j in piece_list:
                        # Finds the rooks 
                        if (j.type == "R" or j.type == "r") and (i.type.isupper() == j.type.isupper()):
                            # verify their the right rook
                            if num == -2 and j.coordinates[0] == "F":
                                # move the rook
                                j.move("H", i.coordinates[1])
                            elif num == 2 and j.coordinates[0] == "D":
                                j.move("A", i.coordinates[1])
            # Only moves the capturing piece and not the captured piece, otherwise the two piece get sorta fused together
            if not i in capture_list:
                i.move(list(move)[0], list(move)[1])
    # Removes the last entry in the capture list
    del capture_list[-1]
    return capture_list, piece_list

# A function to draw the info for the move and the player tags
def display_info(ui, info_list, cmove, headers):
    # gets pygame setup to draw text
    font = pygame.font.SysFont("Ariel", 25)
    WHITE = pygame.Color((255,255,255))
    CYAN = pygame.Color((0,255,239))
    GREEN = pygame.Color((0,255,0))
    RED = pygame.Color((255,0,0))
    # draws the player tags
    ui.blit(font.render(headers["White"], 1, WHITE), (340,705))
    ui.blit(font.render(headers["Black"], 1, WHITE), (340,40))

    # Checks to make sure the move is greater than -1 otherwise it would loop back and display the last moves information when the board is in it's starting position
    if cmove < 0:
        return ui
    # Draws the eval and move info
    ui.blit(font.render(info_list[cmove][0].__str__(), 1, WHITE), (970, 100))
    ui.blit(font.render(info_list[cmove][1].__str__(), 1, WHITE), (970, 200))
    ui.blit(font.render(info_list[cmove][2], 1, WHITE), (970, 300))
    return ui
# Defines the window and run variable
def main_loop(file, info_list):
    # gets some variables setup
    try:
        ran = False
        capture_list = []
        first_run = True
        window = pygame.display.set_mode([1280,720])
        pygame.display.set_caption("Chess Mastermind")
        run = True
        moves, headers = load_game(file)

        # Draws the board to the window
        key = ["A", "B", "C", "D", "E", "F", "G", "H"]
        board = draw_board(None, ['5', '3'], -1)
        piece_list, ui = setup_game(headers)
        window.blit(ui, (0,0))
        cmove = -1
        moves.append(None)
        # Main loop
        while(run):
            # Input loop
            for e in pygame.event.get():
                if e.type == pygame.QUIT:
                    run = False
                # gets arrow keys to run move funcs
                if e.type == pygame.KEYDOWN:
                    # each arrow will move the game and then update the board for that move
                    if e.key == pygame.K_RIGHT:
                        if moves[cmove+1]:
                            
                            capture_list, piece_list = move_ahead(moves[cmove+1], piece_list,capture_list)
                            cmove += 1
                            ran = True
                            ui.fill((0,0,0))
                            ui = display_info(ui, info_list, cmove, headers)
                            window.blit(ui, (0,0))
                    if e.key == pygame.K_LEFT and moves[cmove]:
                        capture_list, piece_list = move_back(moves[cmove], piece_list, capture_list)
                        cmove -= 1
                        ran = True
                        ui.fill((0,0,0))
                        ui = display_info(ui, info_list, cmove, headers)
                        window.blit(ui, (0,0))

            # draws the board
            if cmove > -1:
                num = key.index(moves[cmove][-2:][0].upper())
                board = draw_board(info_list[cmove][2], [num, moves[cmove][-2:][1]], cmove)
            else:
                board = draw_board(None, [0, 0], cmove)
            window.blit(board, (340, 60))
            for i in piece_list:
                #if ran == True or first_run:
                board.blit(i.image, i.pos)
                ran = False
            
            window.blit(board, (340, 60))
            #window.blit(ui, (0,0))
            first_run = False
            # Updates the surface
            pygame.display.flip()
        
        pygame.quit()
    except Exception as err:
        print(f"Error on line {sys.exc_info()[-1].tb_lineno}: {err}")

if __name__ == "__main__":
    main_loop("./games/example.pgn")
