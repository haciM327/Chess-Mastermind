import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2

Rectangle {
    id: config_game
    signal switchPage(string page)
    color: "#000000"
    Text {
        id: label
        visible: true
        color: "#e91e63"
        text: qsTr("Copy and paste your game")
        anchors.top: config_game.top
        anchors.topMargin: 104
        font.pointSize: 32
        font.family: "Arial"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
    TextArea {
        id: pgnInput
        x: 396
        y: 204
        width: 557
        height: 312
        visible: true
        color: "#e91e63"
        placeholderTextColor: "#e91e63"
        font.family: "Arial"
        placeholderText: qsTr("Paste PGN here")
    }

    TextArea {
        id: textArea
        x: 575
        y: 539
        width: 199
        height: 52
        visible: true
        color: "#e91e63"
        font.family: "Roboto"
        placeholderTextColor: "#e91e63"
        placeholderText: qsTr("Enter game name")
    }

    Button {
        id: add
        x: 618
        y: 619
        visible: true
        text: qsTr("Add Game")
        highlighted: false

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }

        onClicked: {
            funcs.addGame(pgnInput.text, textArea.text);
            switchPage("title.qml");
        }
    }
}
