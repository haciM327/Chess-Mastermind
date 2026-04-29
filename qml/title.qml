import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2

Rectangle {
    id: title
    signal switchPage(string page)
    color: "#000000"
    Button {
        id: analyze
        width: 132
        height: 52
        visible: true
        Text {
            id: analyzetext
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 9
            color: "#000000"
            text: "Analyze"
        }
        anchors.verticalCenter: parent.verticalCenter
        icon.cache: false
        display: AbstractButton.TextOnly
        font.family: "Arial"
        flat: false
        highlighted: false
        anchors.verticalCenterOffset: -72
        anchors.horizontalCenterOffset: 0
        checkable: true
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }
        onClicked: {
            switchPage("config_analyzer.qml");
        }
    }

    Text {
        id: label
        visible: true
        color: "#e91e63"
        text: qsTr("Welcome to Chess Mastermind!")
        anchors.top: title.top
        anchors.topMargin: 104
        font.pointSize: 32
        font.family: "Arial"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: __materialLibrary__
    }

    Button {
        id: addGame
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -7
        anchors.horizontalCenterOffset: 0
        width: 132
        height: 52
        visible: true
        Text {
            id: addGametext
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 9
            color: "#000000"
            text: "Add Game"
        }
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }

        onClicked: {
            switchPage("config_game.qml");
        }
    }

    Button {
        id: addEngine
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 58
        anchors.horizontalCenterOffset: 0
        width: 132
        height: 52
        visible: true
        Text {
            id: addEngineText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 9
            color: "#000000"
            text: "Add Engine"

        }
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }

        onClicked: {
            switchPage("config_engine.qml");
        }
    }
}
