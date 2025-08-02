{ ... }:
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

        modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
        "hyprland/submap"
        ];

        modules-center = [
        "idle_inhibitor"
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
    };

    programs.waybar.style = ./waybar-style.css;
}
