import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Services.Pipewire

// Mainly from the example for the logic

Scope {
    id: widget
    property bool inAnimation: false

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Timer {
        id: hider
        interval: 2000
        onTriggered: widget.inAnimation = false
    }

    Connections {
        function onVolumeChanged() {
            widget.inAnimation = true
            hider.restart()
        }

        target: Pipewire.defaultAudioSink?.audio
    }

    LazyLoader {
        active: widget.inAnimation

        PanelWindow {
            width: 100
            height: 100
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: "#80001000"
                radius: height / 4

                Text {
                    text: ""
                    anchors.centerIn: parent
                    font.pointSize: 30
                    color: "white"
                }

                Shape {
                    id: shape
                    anchors.fill: parent
                    anchors.centerIn: parent

                    preferredRendererType: Shape.CurveRenderer

                    ShapePath {
                        fillColor: "transparent"
                        strokeColor: "#80100000"
                        strokeWidth: 5
                        capStyle: ShapePath.RoundCap

                        PathAngleArc {
                            centerX: shape.width / 2
                            centerY: shape.height / 2
                            radiusX: 35
                            radiusY: 35
                            startAngle: 0
                            sweepAngle: 360
                        }
                    }

                    ShapePath {
                        fillColor: "transparent"
                        strokeColor: "white"
                        strokeWidth: 5
                        capStyle: ShapePath.RoundCap

                        PathAngleArc {
                            centerX: shape.width / 2
                            centerY: shape.height / 2
                            radiusX: 35
                            radiusY: 35
                            startAngle: -90
                            sweepAngle: (Pipewire.defaultAudioSink?.audio.volume ?? 0) * 360

                            Behavior on sweepAngle {
                                PropertyAnimation {
                                    duration: 100
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
