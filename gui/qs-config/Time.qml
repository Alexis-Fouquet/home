pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string qtime: {
    Qt.formatDateTime(clock.date, "hh:mm AP")
  }

  readonly property string ftime: {
    Qt.formatDateTime(clock.date, "[ddd MMM dd yyyy] hh:mm AP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
