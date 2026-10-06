import QtQuick 6.6
import QtQuick.Controls.Basic 6.6

Rectangle {
    id: manageGames
    color: "#121722"
    radius: 25
    Text {
        id: gamesText
        text: "Games"
        font.family: libreBaskerville .name
        font.pointSize: 32
        anchors.bottom: gameListView.top
        anchors.left: gameListView.left
        color: "#cccccc"
    }
    ListModel {
        id: gamesListModel

        Component.onCompleted: {
            let games = funcs.getGames() // keeps track of all the games to iterate through

            // A loop that iterates over the entirety of games and appends each listed game to the list item
            for (let i = 0; i < games.length; i++) {
                gamesListModel.append({
                    name: games[i]
                })
            }
        }
    }

    ListView {
        id: gameListView
        anchors.fill: parent
        anchors.leftMargin: 100
        anchors.topMargin: 100
        anchors.bottomMargin: 100
        anchors.rightMargin: 100
        model: gamesListModel
        spacing: 10
        delegate: ItemDelegate {
            width: parent.width

            Text {
                text: model.name
                anchors.leftMargin: 50
                font.pointSize: 22
                color: parent.down ? "#d9b676" : "#cccccc"
            }

            background: Item{}

            Rectangle {
                width: parent.width
                anchors.top: parent.bottom
                anchors.topMargin: 15
                height: 1
                color: "transparent"
                border.color: "#777777"
            }


        }


    }
    FontLoader {
        id: libreBaskerville
        source: "../fonts/LibreBaskerville-Medium.ttf"
    }
}