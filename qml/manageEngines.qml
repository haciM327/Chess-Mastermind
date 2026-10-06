import QtQuick 6.6
import QtQuick.Controls.Basic 6.6

Rectangle {
    id: manageEngines
    color: "#121722"
    radius: 25
    Text {
        id: enginesText
        text: "Engines"
        font.family: libreBaskerville .name
        font.pointSize: 32
        anchors.bottom: engineListView.top
        anchors.left: engineListView.left
        color: "#cccccc"
    }
    ListModel {
        id: engineListModel

        Component.onCompleted: {
            let engines = funcs.getEngines()
            console.log(engines)
            for (let i = 0; i < engines.length; i++) {
                engineListModel.append({
                    name: engines[i]
                })
            }
        }
    }

    ListView {
        id: engineListView
        anchors.fill: parent
        anchors.leftMargin: 100
        anchors.topMargin: 100
        anchors.bottomMargin: 100
        anchors.rightMargin: 100
        model: engineListModel
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