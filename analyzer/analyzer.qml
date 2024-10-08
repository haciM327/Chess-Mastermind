import QtQuick 6.6
import QtQuick.Controls 6.6

ApplicationWindow {
    id: rectangle
    width: 1280
    height: 720
    color: "#000000"
    visible: true
    title: qsTr("Chess Mastermind")
    property bool setup: bridge.load()
    property string best_move: ""
    property string cp: ""
    property string move_type: ""
    property string move: ''
    property string imagepath: ''
    function set_board(fen) {
        rectangle.clear_board()
        rectangle.set_icon(rectangle.move)
        let i = 0
        fen = fen.split(" ")[0]
        let lines = fen.split("/")
        let j = 0
        for (j = 0; j<lines.length; j++) {
            let str = lines[j].split('')
            str = str.reverse()
            lines[j] = str.join('')
        }
        fen = lines.reverse().join('')
        let pos = 0
        if (bridge.getport()) {
            rectangle.imagepath == "../share/chess-mastermind/img/"
        } else {
            rectangle.imagepath == "/usr/local/share/chess-mastermind/img/"
        }
        while (i < 64) {
            let nums = ['1','2','3','4','5','6','7','8']
            if (nums.includes(fen[i])) {
                pos+=parseInt(fen[i])-1
                i++
                pos++
                continue
            }
            if (fen[i] === 'R') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_rook.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'N') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_knight.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'B') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_bishop.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'P') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_pawn.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'K') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_king.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'Q') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/white_queen.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'r') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_rook.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'n') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_knight.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'b') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_bishop.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'p') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_pawn.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'k') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_king.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            if (fen[i] === 'q') {
                eval("piece" + String(65-(pos + 1)) + ".visible = true")
                eval("piece" + String(65-(pos + 1)) + ".source = '" + rectangle.imagepath + "img/black_queen.png'")
                eval("piece" + String(65-(pos + 1)) + ".x = 6")
                eval("piece" + String(65-(pos + 1)) + ".y = 6")
                eval("piece" + String(65-(pos + 1)) + ".width = 60")
                eval("piece" + String(65-(pos + 1)) + ".height = 60")
                i++
                pos++
                continue
            }
            i++
            pos++
        }
        cp.text = qsTr(rectangle.cp)
        best_move.text = qsTr(rectangle.best_move)
        move_type.text = qsTr(rectangle.move_type)
    }
    function clear_board() {
        for (let i = 1; i<=64; i++) {
            eval("piece" + String(i) + ".visible = false")
        }
    }
    function set_icon(move) {
        if (String(move) != '') {
            let pos = [move.split('')[2], move.split('')[3]]
            let keyx = {
                'a': 390,
                'b': 465,
                'c': 540,
                'd': 615,
                'e': 690,
                'f': 765,
                'g': 840,
                'h': 915
            }
            let keyy = {
                '8': 55,
                '7': 130,
                '6': 205,
                '5': 280,
                '4': 355,
                '3': 430,
                '2': 505,
                '1': 580
            }

            moveIcon.x = keyx[pos[0]]
            moveIcon.y = keyy[pos[1]]
        }
    }

    Text {
        visible: false
        id: white_player
        x: 340
        y: 665
        color: 'white'
        text: qsTr('placeholder')
    }

    Text {
        visible: false
        id: black_player
        x: 340
        y: 30
        color: 'white'
        text: qsTr('placeholder')
    }

    Grid {

        visible: false
        id: board
        x: 340
        y: 60
        width: 600
        height: 600
        opacity: 1
        clip: true
        rows: 8
        columns: 8
        property string fen: bridge.get_fen()

        Rectangle {
            id: rectangle1
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            focus: true
            Text {
                id: cor8
                text: qsTr("8")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece1
                source: rectangle.imagepath + "img/white_rook.png"
                visible: false
            }
            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Left) {
                    let info = bridge.move_back()
                    rectangle.best_move = info[0]
                    rectangle.cp = info[1]
                    rectangle.move_type = String(info[2])
                    board.fen = info[3]
                    if (bridge.get_move_number() != 0) {
                        rectangle.move = info[4]
                    }
                    else {
                        rectangle.move_type = ""
                        rectangle.move = ""
                        moveIcon.visible = false
                    }
                    rectangle.set_board(board.fen)
                    moveIcon.source = rectangle.imagepath + 'img/' + String(info[2]) + '.png'

                } else if (event.key === Qt.Key_Right) {
                    let info = bridge.move_ahead()
                    rectangle.best_move = info[0]
                    rectangle.cp = info[1]
                    rectangle.move_type = String(info[2])
                    board.fen = info[3]
                    rectangle.move = info[4]
                    rectangle.set_board(board.fen)
                    moveIcon.source = rectangle.imagepath + 'img/' + String(info[2]) + '.png'
                    if (bridge.get_move_number() != 0) {
                        moveIcon.visible = true
                    }
                }
                // Add more key handling as needed
            }
        }

        Rectangle {
            id: rectangle2
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece2
                source: rectangle.imagepath + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle3
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece3
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle4
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece4
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle5
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece5
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle6
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece6
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle7
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece7
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }
        Rectangle {
            id: rectangle8
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece8
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle9
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: cor7
                text: qsTr("7")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece9
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle10
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece10
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle11
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece11
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle12
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece12
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle13
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece13
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle14
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece14
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle15
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece15
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle16
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece16
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }
        Rectangle {
            id: rectangle17
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: cor6
                text: qsTr("6")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece17
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle18
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece18
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle19
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece19
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle20
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece20
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle21
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece21
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle22
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece22
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle23
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece23
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }
        Rectangle {
            id: rectangle24
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece24
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle25
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: cor5
                text: qsTr("5")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece25
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle26
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece26
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle27
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece27
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle28
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece28
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle29
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece29
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle30
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece30
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle31
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece31
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle32
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece32
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle33
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: cor4
                text: qsTr("4")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece33
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle34
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece34
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle35
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece35
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle36
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece36
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle37
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece37
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle38
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece38
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle39
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece39
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle40
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece40
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle41
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: cor3
                text: qsTr("3")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece41
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle42
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece42
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle43
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece43
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle44
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece44
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle45
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece45
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle46
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece46
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle47
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece47
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle48
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece48
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle49
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: cor2
                text: qsTr("2")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece49
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle50
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece50
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle51
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece51
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle52
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece52
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle53
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece53
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle54
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece54
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle55
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Image {
                id: piece55
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle56
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Image {
                id: piece56
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle57
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: corA
                text: qsTr("A")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Text {
                id: cor1
                text: qsTr("1")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
            Image {
                id: piece57
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle58
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: corB
                text: qsTr("B")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece58
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle59
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: corC
                text: qsTr("C")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece59
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle60
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: corD
                text: qsTr("D")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece60
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle61
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: corE
                text: qsTr("E")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece61
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle62
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: corF
                text: qsTr("F")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece62
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle63
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
            Text {
                id: corG
                text: qsTr("G")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece63
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }

        Rectangle {
            id: rectangle64
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: corH
                text: qsTr("H")
                font.pixelSize: 18
                font.bold: true
                x: 60
                y: 55
            }
            Image {
                id: piece64
                source: rectangle.imagepath  + "img/white_rook.png"
                visible: false
            }
        }
    }



    Text {
        id: cp
        visible: false
        text: ''
        x: 950
        y: 100
        font.pointSize: 30
        color: "#FFFFFF"

    }
    Text {
        id: best_move
        visible: false
        text: ''
        x: 950
        y: 150
        font.pointSize: 30
        color: "#FFFFFF"
    }
    Text {
        id: move_type
        visible: false
        text: ''
        x: 950
        y: 200
        font.pointSize: 30
        color: '#FFFFFF'
    }
    Image {
        id: moveIcon
        visible: false
        source: rectangle.imagepath + "img/placeholder.png"
        width: 30
        height: 30
    }

    Button {
        id: cont
        visible: true
        anchors.centerIn: parent
        width: 200
        height: 100
        text: "Continue"
        onClicked: {
            if (rectangle.setup === true) {
                cont.visible = false
                board.visible = true
                //whiteRook.visible = true
                let i = 0
                rectangle.set_board(bridge.get_fen())
                rectangle1.focus = true
                cp.visible = true
                best_move.visible = true
                move_type.visible = true
                white_player.text = bridge.getheads()['White']
                white_player.visible = true
                black_player.text = bridge.getheads()['Black']
                black_player.visible = true
                //moveIcon.visible = true
            } //else {
            //bridge.error("An error has occured, this is likely due to the engine picked out.\nPlease ensure you pick an engine that works with your machine.\nIt may also be due to the depth or game selected.")
            //Qt.quit()
            //}
        }
    }
}
