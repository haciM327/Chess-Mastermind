import QtQuick 6.6
import QtQuick.Controls.Basic 6.6
import main

Window {
    id: mainPage
    width: 1280
    height: 720
    color: "#05070d"
    visibility: Window.Maximized

    function loadContent(s) {
        contentLoader.source = s;
    }

    Rectangle {
        id: verticalDivider
        width: 1
        height: parent.height
        color: "#333333"
        anchors.left: parent.left
        anchors.leftMargin: 226
    }

    Rectangle {
        id: centerToken
        radius: 25
        color: "#121722"
        height: parent.height - 150
        width: parent.width - 276
        anchors.left: verticalDivider.left
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 100

        Loader {
            id: contentLoader
            source: "homeContent.qml"

            anchors.fill: parent
        }


    }

    Rectangle {
        id: leftBar
        color: "transparent"
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        width: 226

        Image {
            id: logo
            transformOrigin: Item.TopLeft
            anchors.top: parent.top
            anchors.left: parent.left
            width: 226
            height: 226
            source: "../img/chess-mastermind.ico"
            scale: 1
        }

        Button {
            id: homeLeftBar
            anchors.left: parent.left
            y: logo.height + 50
            width: 226
            height: 50
            background: Rectangle {
                id: homeLeftBarBackground
                border.width: 1
                anchors.fill: parent
                color: parent.hovered ? "#090b13" : "#06080e"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Home'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
            onClicked: loadContent("homeContent.qml");
        }

        Button {
            id: analyzeLeftBar
            anchors.left: parent.left
            y: logo.height + 100
            width: 226
            height: 50
            background: Rectangle {
                id: analyzeLeftBarBackground
                border.width: 1
                anchors.fill: parent
                color: parent.hovered ? "#090b13" : "#06080e"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Analyze'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
            onClicked: loadContent("configureAnalyzer.qml");
        }
        Button {
            id: gamesLeftBar
            anchors.left: parent.left
            y: logo.height + 150
            width: 226
            height: 50
            background: Rectangle {
                id: gamesLeftBarBackground
                border.width: 1
                anchors.fill: parent
                color: parent.hovered ? "#090b13" : "#06080e"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Games'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
            onClicked: loadContent("manageGames.qml");
        }
        Button {
            id: enginesLeftBar
            anchors.left: parent.left
            y: logo.height + 200
            width: 226
            height: 50
            background: Rectangle {
                id: enginesLeftBarBackground
                border.width: 1
                anchors.fill: parent
                color: parent.hovered ? "#090b13" : "#06080e"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Engines'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
            onClicked: loadContent("manageEngines.qml");
        }
        /* Planned feature
        Button {
            id: analysesLeftBar
            anchors.left: parent.left
            y: logo.height + 250
            width: 226
            height: 50
            background: Rectangle {
                id: analysesLeftBarBackground
                border.width: 1
                anchors.fill: parent
                color: parent.hovered ? "#090b13" : "#06080e"
                radius: 3
                Text {
                    anchors.centerIn: parent
                    text: 'Analyses'
                    font.family: libreBaskerville.name
                    font.pointSize: 18
                    color: parent.parent.down ? "#d9b676" : "#c9a15b"
                }
            }
        }*/
    }

    FontLoader {
        id: libreBaskerville
        source: "../fonts/LibreBaskerville-Medium.ttf"
    }

    Qmlfuncs {
        id: funcs
        objectName: "funcs"
        function reportProgress(progress: int) {
            percent.text = progress.toString() + '%';
            progressBarFill.width = progressBarOutline.width * (parseInt(percent.text.split('%')[0]) / 100);
        }

        function finished() {
            percent.text = "100%";
            progressBarFill.width = progressBarOutline.width;
            switchToPage("analyzer.qml");
        }

        function finished_download() {
            switchToPage("title.qml");
            progressBarFill.visible = false;
            progressBarOutline.visible = false;
            percent.visible = false;
        }
    }

}