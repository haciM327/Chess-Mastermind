import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2

Rectangle {
    id: config_analyzer
    signal switchPage(string page)
    color: "#000000"
    Text {
        id: label
        visible: true
        color: "#e91e63"
        text: qsTr("Configure the analyzer")
        anchors.top: config_analyzer.top
        anchors.topMargin: 104
        font.pointSize: 32
        font.family: "Arial"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ComboBox {
        id: gamelist
        x: 289
        y: 340
        width: 137
        height: 40
        visible: true
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

                ScrollIndicator.vertical: ScrollIndicator {}
            }

            background: Rectangle {
                border.color: "#e91e63"
                color: "#e91e63"
                radius: 2
            }
        }
        Component.onCompleted: {
            gamelist.model = funcs.getGames();
        }
    }

    ComboBox {
        id: enginelist
        x: 869
        y: 340
        width: 137
        height: 40
        visible: true
        model: ["placeholder", "these should not be showing"]
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

                ScrollIndicator.vertical: ScrollIndicator {}
            }

            background: Rectangle {
                border.color: "#e91e63"
                color: "#e91e63"
                radius: 2
            }
        }
        Component.onCompleted: {
            enginelist.model = funcs.getEngines();
        }
    }

    Rectangle {
        id: depthrect
        visible: true
        width: 165
        height: 25
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 10
        border.color: "#e91e63"
        border.width: 1
        color: "black"
        TextArea {
            id: depth
            width: 160
            anchors.centerIn: parent
            font.pointSize: 10
            visible: true
            color: "#e91e63"
            placeholderTextColor: "#e91e63"
            placeholderText: "Enter depth (18)"
            selectByMouse: true
        }
    }

    Rectangle {
        id: threadrect
        visible: true
        width: 165
        height: 25
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        border.color: "#e91e63"
        border.width: 1
        color: "black"
        TextArea {
            id: threads
            width: 160
            font.pointSize: 10
            visible: true
            color: "#e91e63"
            placeholderTextColor: "#e91e63"
            placeholderText: "How many threads? (1)"
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
            runanalyzer.visible = false;
            enginelist.visible = false;
            gamelist.visible = false;
            depthrect.visible = false;
            threadrect.visible = false;
            label.text = "Analyzing..."
            progressBarOutline.visible = true;
            progressBarFill.visible = true;
            progressBarFill.width = 0;
            percent.visible = true;
            funcs.runAnalyzer("./games/" + gamelist.currentValue, "./engines/" + enginelist.currentValue, depth.text, threads.text);
        }
    }


}
