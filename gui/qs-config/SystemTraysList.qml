pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

RowLayout {
    required property PanelWindow window
    id: root

    Repeater {
        model: SystemTray.items

        Rectangle {
            required property SystemTrayItem modelData
            id: current
            implicitWidth: img.width + 10
            implicitHeight: img.height
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                function startMenu() {
                    current.modelData.display(root.window, 1000, 30)
                }

                onClicked: startMenu()
            }

            Image {
                source: current.modelData.icon
                id: img
                anchors.centerIn: parent
                width: 15
                height: 15
            }
        }
    }
}
