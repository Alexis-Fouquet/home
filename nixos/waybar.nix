{ ... }:
{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
    };

    programs.waybar.settings.mainBar = {
        height = 35;
        spacing = 5;

        modules-left = [
        "hyprland/workspaces"
        "hyprland/submap"
        ];

        modules-center = [
        "idle_inhibitor"
        "hyprland/window"
        ];

        modules-right = [
        "mdp"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
        ];
    };
}
