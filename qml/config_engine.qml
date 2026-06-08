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
            if (config_engine.os == "windows") {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-windows-" + config_engine.arch + "-" + typeList.currentValue + ".zip", engineName.text, typeList.currentValue);
            } else if (!typeList.currentValue === "64-Bit") {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-" + config_engine.os + "-" + config_engine.arch + "-" + typeList.currentValue + ".tar", engineName.text, typeList.currentValue);
            } else {
                funcs.download("https://github.com/official-stockfish/Stockfish/releases/download/sf_18/stockfish-ubuntu-x86-64.tar", engineName.text, typeList.currentValue);
            }
            label.text = "Downloading";
            typeList.visible = false;
            download.visible = false;
            engineName.visible = false;
            progressBarFill.visible = true;
            progressBarOutline.visible = true;
            percent.visible = true;
        }
    }
    ComboBox {
        id: typeList
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 120
        width: 138
        height: 40
        visible: true
        model: ["AVX2", "POPCNT", "AVX-512ICL", "VNNI-512", "AVX-512", "AVX-VNNI", "BMI2", "64-bit"]
        property var models: [["AVX2", "POPCNT", "AVX-512ICL", "VNNI-512", "AVX-512", "AVX-VNNI", "BMI2", "64-bit"], ["Armv8", "Armv8 Dot"], ["Apple Silicon"], ["BMI2", "AVX2", "POPCNT", "64-bit"]]
        delegate: ItemDelegate {
            width: typeList.width
            contentItem: Text {
                text: modelData
                color: "#000000"
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
        }
        background: Rectangle {
            implicitWidth: 138
            implicitHeight: 40
            color: "#e91e63"
            border.color: "#000000"
            border.width: 1
        }
        popup: Popup {
            y: 39
            width: typeList.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: typeList.popup.visible ? typeList.delegateModel : null
                currentIndex: typeList.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {}
            }

            background: Rectangle {
                border.color: "#e91e63"
                color: "#e91e63"
                radius: 2
            }
        }

        Component.onCompleted: {
            config_engine.os = funcs.getos();
            config_engine.arch = funcs.getarch();

            if (config_engine.os == "windows" || config_engine.os == "linux") {
                typeList.model = models[0];
            } else { // has to be macos
                if (config_engine.arch == "apple-silicon") {
                    typeList.model = models[2];
                } else { // has to be intel mac
                    typeList.model = models[3];
                }
            }
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
