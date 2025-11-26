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
                color: "#333333AA"
                id: p

                Text {
                    id: ch
                    text: {
                        Math.round(p.modelData.percentage * 100) + "%"
                    }
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
