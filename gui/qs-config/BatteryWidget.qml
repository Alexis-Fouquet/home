import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick

Rectangle {
    RowLayout {
        id: layout
        anchors.centerIn: parent
        Repeater {
            model: UPower.displayDevice

            delegate: Rectangle {
                required property UPowerDevice modelData
                color: "#CC222255"
                id: p

                function getBattery() {
                    var rounded = Math.round(p.modelData.percentage * 100);
                    return "  " + rounded + "%";
                }

                Text {
                    id: ch
                    text: p.getBattery()
                    color: {
                        UPower.onBattery ? "#EEAAAA" : "#AAEEAA"
                    }
                    anchors.centerIn: parent
                }

                implicitHeight: ch.implicitHeight + 15
                implicitWidth: ch.implicitWidth + 20
            }
        }
    }

    color: "transparent"
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
}
