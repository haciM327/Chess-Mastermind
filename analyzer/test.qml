// main_window.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300

    Rectangle {
        width: parent.width
        height: parent.height
        color: bridge.getColor("blue") // Call Python function

        Button {
            text: "Change Color"
            anchors.centerIn: parent
            onClicked: {
                // No JS signal handler needed
                bridge.changeColor(); // Call Python function
            }
        }
    }
}