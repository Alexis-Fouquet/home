pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Variants {
  model: Quickshell.screens
  default property list<ButtonObject> buttons
  id: root

  PanelWindow {
    id: panel

    required property var modelData
    screen: modelData

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    mask: layout
    color: "transparent"

    implicitWidth: layout.width
    implicitHeight: layout.height

    GridLayout {
        id: layout
        anchors.centerIn: panel

        columns: 2

        Repeater {
            model: root.buttons

            Rectangle {
                required property ButtonObject modelData;
                id: parent

                color: "red"
                border.color: "black"
                border.width: 3

                width: 100
                height: 100

                Text {
                    anchors.centerIn: parent
                    text: parent.modelData.text
                }
            }
        }
    }
  }
}
