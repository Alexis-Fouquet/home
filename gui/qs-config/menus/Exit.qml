import Quickshell
import QtQuick

Scope {
    OverlayMenu {
        id: win

        ButtonObject {
            command: "shutdown 0"
            text: "Shutdown"
            icon: ""
        }

        ButtonObject {
            command: "hyprlock"
            text: "Lock"
            icon: "󰷛"
        }

        ButtonObject {
            command: "reboot"
            text: "Reboot"
            icon: "󰑓"
        }

        ButtonObject {
            command: ""
            text: "Cancel"
            icon: "󰜺"
        }
    }

    function start() {
        console.log("Starting menu");
        win.start();
    }
}
