import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick

Rectangle {
    RowLayout {
        id: layout
        anchors.centerIn: parent
        Repeater {
            model: UPower.devices

            delegate: Rectangle {
                required property UPowerDevice modelData
                color: "#333333AA"
                id: p

                Text {
                    id: ch
                    text: {
                        (p.modelData.percentage * 100) + "%"
                    }
                    color: {
                        p.modelData.isLaptopBattery ? "#AAEEEE" : "#AAAAAA"
                    }
                    anchors.centerIn: parent
                }

                implicitHeight: ch.implicitHeight + 15
                implicitWidth: ch.implicitWidth + 20
            }
        }
    }

    color: "transparent"
    implicitHeight: layout.implicitHeight + 15
    implicitWidth: layout.implicitWidth + 20
}
