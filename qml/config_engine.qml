import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2

Rectangle {
    id: config_engine
    signal switchPage(string page)
    color: "#000000"
    property string os
    property string arch
    Text {
        id: label
        visible: true
        color: "#e91e63"
        text: qsTr("Select an engine")
        anchors.top: config_engine.top
        anchors.topMargin: 104
        font.pointSize: 32
        font.family: "Arial"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Button {
        id: download
        width: 138
        height: 52
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 114
        text: "Download"
        visible: true
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
            radius: 6
        }
        onClicked: {
            if (funcs.getos() === "linux") {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/download/sf_19/stockfish-linux-" + funcs.getarch() + "-universal.tar.gz", engineName.text)
            } else if (funcs.getos() === "windows") {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/download/sf_19/stockfish-windows-" + funcs.getarch() + "-universal.zip", engineName.text)
            } else if (funcs.getos() === "macos") {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/download/sf_19/stockfish-macos-universal.tar.gz", engineName.text)
            } else {
                console.log("ERROR: computer not supported. Try manually downloading and installing an engine to the engines folder.");
            }
            label.text = "Downloading";

            download.visible = false;
            engineName.visible = false;
            progressBarFill.visible = true;
            progressBarOutline.visible = true;
            percent.visible = true;
        }
    }

    TextArea {
        id: engineName
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -120
        width: 138
        height: 30
        visible: true
        color: "#e91e63"
        font.family: "Roboto"
        placeholderTextColor: "#e91e63"
        placeholderText: qsTr("Enter engine name")

        Rectangle {
            id: outline
            anchors.centerIn: parent
            width: 138
            height: 30
            visible: true
            color: "transparent"
            border.color: "#e91e63"
        }
    }
}
