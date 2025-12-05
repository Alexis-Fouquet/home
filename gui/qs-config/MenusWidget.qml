import QtQuick
import QtQuick.Layouts
import "menus"

Rectangle {
    id: root
    required property Exit exit

    RowLayout {
        id: layout
        anchors.centerIn: parent

        Text {
            text: "󰍝"
            color: "#EEEEEE"
            font.pointSize: 16
        }

        Rectangle {
            visible: mouse.containsMouse
            implicitWidth: txt.width + 10
            implicitHeight: 15
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                function startMenu() {
                    console.log("Clicked");
                    root.exit.start();
                }

                onClicked: startMenu()
            }

            Text {
                id: txt
                text: "󱕰"
                color: "#EEEEEE"
                font.pointSize: 10
                anchors.centerIn: parent
            }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    color: "#CC222255"
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + 20

    Behavior on implicitWidth {
        PropertyAnimation {
            duration: 100
        }
    }
}
