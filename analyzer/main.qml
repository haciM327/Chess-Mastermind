

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.6
import QtQuick.Controls 6.6

Window {
    id: rectangle
    width: 1280
    height: 720
    color: "#000000"
    visible: true
    title: qsTr("Chess Mastermind")

    Grid {
        visible: false
        id: board
        x: 340
        y: 60
        width: 600
        height: 600
        opacity: 1
        visible: true
        clip: true
        rows: 8
        columns: 8
        Rectangle {
            id: rectangle1
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
            Text {
                id: cor8
                text: qsTr("8")
                font.pixelSize: 18
                font.bold: true
                x: 0
                y: 0
            }
        }

        Rectangle {
            id: rectangle2
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle3
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle4
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle5
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle6
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle7
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }
        Rectangle {
            id: rectangle8
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle10
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle11
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle12
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle13
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle14
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle15
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle16
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle18
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle19
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle20
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle21
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle22
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle23
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }
        Rectangle {
            id: rectangle24
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle26
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle27
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle28
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle29
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle30
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle31
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle32
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle34
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle35
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle36
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle37
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle38
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle39
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }
        Rectangle {
            id: rectangle40
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle42
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle43
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle44
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle45
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle46
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle47
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle48
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
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
        }

        Rectangle {
            id: rectangle50
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle51
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle52
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle53
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }

        Rectangle {
            id: rectangle54
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
        }

        Rectangle {
            id: rectangle55
            width: 75
            height: 75
            color: "#E9EDCC"
            border.width: 0
        }
        Rectangle {
            id: rectangle56
            width: 75
            height: 75
            color: "#779954"
            border.width: 0
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
        }
    }

    Image {
        id: whiteRook
        source: "file"
    }
}
