{ pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
    };

    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        "$browser" = "firefox";
        "$terminal" = "kitty";
        "$menu" = "wofi --show drun";
        bind = [
        "$mod, B, exec, $browser"
        "$mod, D, exec, $menu"
        "$mod, T, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, E, exit,"
        ];
    };

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins;
    [
    hyprexpo
    ];
}
