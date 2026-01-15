import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2
import main

Window {
    id: rectangle
    width: 1280
    height: 720
    color: "#000000"
    property alias textAreaColor: pgnInput.color
    visible: true

    Qmlfuncs {
<<<<<<< Updated upstream
        id:funcs
=======
        id: funcs
        objectName: "funcs"
        function reportProgress(progress: int) {
            // `value` is provided by the signal
            percent.text = progress.toString() + '%';
            progressBarFill.width = progressBarOutline.width * (parseInt(percent.text.split('%')[0]) / 100);

        }

        // matches `void finished()` in C++
        function finished() {
            percent.text = "100%"
            progressBarFill.width = progressBarOutline.width;
            switchToPage("analyzer.qml")


        }
>>>>>>> Stashed changes
    }

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
            label.text = qsTr("Select game depth and engine")
            analyze.visible = false
            addGame.visible = false
            gamelist.visible = true
            gamelist.model = funcs.getGames()
            enginelist.visible = true
            enginelist.model = funcs.getEngines()
            depthrect.visible = true
            depth.visible = true
            runanalyzer.visible = true
        }
    }

<<<<<<< Updated upstream
    Text {
        id: label
        visible: true
        color: "#e91e63"
        text: qsTr("Welcome to Chess Mastermind!")
        anchors.top: analyze.bottom
        anchors.topMargin: -230
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
        x: 574
        y: 407
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
            analyze.visible = false
            addGame.visible = false
            label.text = "Enter your game info"
            pgnInput.visible = true
            textArea.visible = true
            add.visible = true
        }
    }

    TextArea {
        id: pgnInput
        x: 396
        y: 204
        width: 557
        height: 312
        visible: false
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
        visible: false
        color: "#e91e63"
        font.family: "Roboto"
        placeholderTextColor: "#e91e63"
        placeholderText: qsTr("Enter game name")
    }

    Button {
        id: add
        x: 618
        y: 619
        visible: false
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

        onClicked:
            funcs.addGame(pgnInput.text, textArea.text)
    }

    ComboBox {
        id: gamelist
        x: 289
        y: 340
        width: 137
        height: 40
        visible: false
        model: ["test", "moretest"]
        delegate: ItemDelegate {
                width: gamelist.width
                contentItem: Text {
                    text: modelData
                    color: "#000000"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
            }
        background: Rectangle {
            implicitWidth: 137
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
        }
        popup: Popup {
                y: 39
                width: gamelist.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: gamelist.popup.visible ? gamelist.delegateModel : null
                    currentIndex: gamelist.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    border.color: "#e91e63"
                    color: "#e91e63"
                    radius: 2
                }
            }
    }

    ComboBox {
        id: enginelist
        x: 869
        y: 340
        width: 137
        height: 40
        visible: false
        model: ["test", "moretest"]
        delegate: ItemDelegate {
                width: enginelist.width
                contentItem: Text {
                    text: modelData
                    color: "#000000"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
            }
        background: Rectangle {
            implicitWidth: 137
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
        }
        popup: Popup {
                y: 39
                width: enginelist.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: enginelist.popup.visible ? enginelist.delegateModel : null
                    currentIndex: enginelist.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    border.color: "#e91e63"
                    color: "#e91e63"
                    radius: 2
                }
            }
    }
    Rectangle {
        id: depthrect
        visible: false
        width: 137
        height: 25
        x: 572
        y: 350
        border.color: "#e91e63"
        border.width: 1
        color: "black"
        TextInput {
            id: depth
            y:2.5
            x:2.5
            width: 134
            font.pointSize: 10
            visible: false
            color: "#e91e63"
            text: "Enter a depth value"
            selectByMouse: true

        }
    }

    Button {
        id: runanalyzer
        width: 132
        height: 52
        x: 574
        y: 500
        text: "Analyze!"
        visible: false
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }
        onClicked: {
            rectangle.visible = false
            if (funcs.getos() == 'windows') {
                funcs.runAnalyzer(".\\games\\" + gamelist.currentValue, ".\\engines\\" + enginelist.currentValue, depth.text)
            } else {
                funcs.runAnalyzer("./games/" + gamelist.currentValue, "./engines/" + enginelist.currentValue, depth.text)
            }
            rectangle.visible = true

        }


    }

=======

    Rectangle {
        id: progressBarOutline
        color: "#adadad"
        width: 200
        height: 15
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50
        visible: false
        radius: 10
    }

    Rectangle {
        id: progressBarFill
        color: "#e91e63"
        width: 0
        height: progressBarOutline.height
        anchors.left: progressBarOutline.left
        anchors.top: progressBarOutline.top
        visible: false
        radius: 10
    }
    Text {
        id: percent
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50
        visible: false
        text: "0%"
        color: "#000000"
        font.pointSize: 10
    }



>>>>>>> Stashed changes
}
