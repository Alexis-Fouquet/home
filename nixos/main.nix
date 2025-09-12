{ ... }:
{
    imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
    ];

    /* Notifications */
    services.swaync.enable = true;
    /* libnotify is placed in configuration.nix */

    /* Wifi - use nmcli / nmtui otherwise */
    services.network-manager-applet.enable = true;

    services.flameshot.enable = true;
}
