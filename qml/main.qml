import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2
import main

Window {
    id: rectangle
    width: 1280
    height: 720
    color: "#000000"
    visible: true

    property string currentQmlFile: "menu.qml"

    function switchToPage(page) {
        currentQmlFile = page;
        loader.source = page;
    }

    Qmlfuncs {
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
    }

        Loader {
                id: loader
                source: rectangle.currentQmlFile
                anchors.fill: parent
            }

            Connections {
                target: loader.item
                function onSwitchPage(page) {
                    switchToPage(page);
                }
            }


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
}
