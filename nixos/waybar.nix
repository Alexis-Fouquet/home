{ ... }:
let baseBatteryInfo = "{icon} {capacity}%"; in
{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        /* Debug only */
        systemd.enableInspect = false;
    };

    programs.waybar.settings.mainBar = {
        height = 35;
        spacing = 5;
        margin = "5";

        modules-left = [
        "idle_inhibitor"
        "hyprland/workspaces"
        "hyprland/window"
        "hyprland/submap"
        ];

        modules-center = [
        "keyboard-state"
        ];

        modules-right = [
        "mpd"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
        "bluetooth"
        ];

        keyboard-state = {
            numlock = true;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
                locked = "";
                unlocked = "";
            };
        };

        idle_inhibitor = {
            format = "{icon}";
            format-icons = {
                activated = "";
                deactivated = "";
            };
        };

        cpu = {
            format = " {usage}%";
            tooltip = false;
        };

        memory = {
            format = " {}%";
        };

        battery = {
            states = {
                /* Good and normal are used to hide when the battery is high */
                good = 100;
                normal = 80;
                warning = 20;
                critical = 10;
            };
            format = baseBatteryInfo;
            format-good = ""; # hide
            format-normal = baseBatteryInfo; # just in case
            format-warning = baseBatteryInfo;
            format-full = "";
            format-charging = "${baseBatteryInfo} {time}";
            format-plugged = "";
            format-icons = ["" "" "" "" ""];
        };

        pulseaudio = {
            /* Mainly from the wiki */
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{icon} {volume}% {format_source}";
            format-bluetooth-muted = "{icon} X {format_source}";
            format-muted = "X {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                default = ["" "" ""];
            };
        };

        network = {
            format-wifi = " {essid} ({signalStrength}%)";
            format-ethernet = "E {ipaddr}/{cidr}";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "L {ifname} (No IP)";
            format-disconnected = "⚠ Disconnected";
        };

        temperature = {
            format = " {temperatureC}°C";
        };
    };

    programs.waybar.style = ./waybar-style.css;
}
