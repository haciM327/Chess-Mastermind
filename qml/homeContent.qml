import QtQuick 6.6
import QtQuick.Controls.Basic 6.6

Rectangle {
    id: homeContent
    color: "#121722"
    radius: 25

    Rectangle {
        id: analyzeContent
        color: "transparent"
        anchors.left: parent.left
        anchors.top: parent.top
        border.color: "#8b6a3d"
        height: parent.height * .2
        width: parent.width - 200
        anchors.leftMargin: 100
        anchors.topMargin: 50
        radius: 5
        border.width: 1

        Text {
            id: analyzeText

            text: 'Analyze a new game'
            font.pointSize: 32
            font.family: libreBaskerville.name
            color: "#cccccc"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * .15
            anchors.topMargin: parent.height * .25

            Text {
                id: analyzeSubtext

                text: 'Analyze a game to help you learn and improve'
                font.pointSize: 22
                font.family: libreBaskerville.name
                color: "#888888"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.height
            }
        }

        Button {
            id: startAnalysis

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: parent.width * .1
            anchors.topMargin: parent.height * .2
            width: 250
            height: 60
            hoverEnabled: true
            background: Rectangle {
                border.color: parent.hovered ? "#d9b676" : "#8b6a3d"
                border.width: 1
                anchors.fill: parent
                color: "transparent"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Start Analysis'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }

        }

        Button {
            id: addGame

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * .2
            anchors.rightMargin: parent.width * .1
            width: 250
            height: 60
            hoverEnabled: true
            background: Rectangle {
                border.color: parent.hovered ? "#d9b676" : "#8b6a3d"
                border.width: 1
                anchors.fill: parent
                color: "transparent"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Add Game'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
        }
    }

    FontLoader {
        id: libreBaskerville
        source: "../fonts/LibreBaskerville-Medium.ttf"
    }
}