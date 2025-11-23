import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick

Rectangle {
    id: root

    RowLayout {
        id: layout
        anchors.centerIn: parent
        Repeater {
            model: Hyprland.workspaces

            delegate: Text {
                required property HyprlandWorkspace modelData
                text: {
                    modelData.hasFullscreen ? "[" + modelData.id + "]" :
                    modelData.id
                }
                color: {
                    modelData.focused ? "#AAEEEE" :
                    modelData.active ? "#AAEEAA" : "#AAAAAA"
                }
            }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
    }

    implicitHeight: layout.implicitHeight + 15
    implicitWidth: layout.implicitWidth + 20
    color: "#333333AA"
}
