import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        Text {
            text: mouse.containsMouse ? Time.ftime : Time.qtime
            color: "#EEEEEE"
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
    }

    color: "#CC222255"
    implicitHeight: layout.implicitHeight + 15
    implicitWidth: layout.implicitWidth + 20

    Behavior on implicitWidth {
        PropertyAnimation {
            duration: 100
        }
    }
}
