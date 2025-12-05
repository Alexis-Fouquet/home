pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Variants {
  default property list<ButtonObject> buttons
  id: root

  function start() {
      model = Quickshell.screens;
  }

  PanelWindow {
    id: panel

    required property var modelData
    screen: modelData

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    mask: Region {
        item: layout
    }
    color: "transparent"

    implicitWidth: layout.width
    implicitHeight: layout.height

    GridLayout {
        id: layout

        columns: 2

        Repeater {
            model: root.buttons

            Rectangle {
                required property ButtonObject modelData;
                id: parent

                color: "#BBA0B0C0"
                border.color: "black"
                border.width: 3

                width: 100
                height: 100

                function exec() {
                    console.log("Action executed");
                    modelData.exec();
                    root.model = [];
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: parent.exec()
                }

                ColumnLayout {
                    anchors.centerIn: parent

                    Text {
                        text: parent.modelData.icon
                        Layout.alignment: Qt.AlignCenter
                        font.pointSize: 30
                    }

                    Text {
                        text: parent.modelData.text
                        Layout.alignment: Qt.AlignCenter
                    }
                }
            }
        }
    }
  }
}
