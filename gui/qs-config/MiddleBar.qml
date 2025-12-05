import Quickshell
import QtQuick.Layouts
import "menus"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30
      color: "transparent"

      RowLayout {
          anchors.centerIn: parent
          ClockWidget { }
          WorkspaceWidget { }
          BatteryWidget { }
          MenusWidget {
              exit: Exit { }
          }
      }
    }
  }
}
