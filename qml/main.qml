import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window 6.2
import main

Window {
    id: rectangle
    width: 1280
    height: 720
    color: "#000000"
    //property alias textAreaColor: pgnInput.color
    visible: true

    property string currentQmlFile: "menu.qml"

    function switchToPage(page) {
        currentQmlFile = page;
        loader.source = page;
    }

    Qmlfuncs {
        id: funcs
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
}
