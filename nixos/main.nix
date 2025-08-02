{ ... }:
{
    imports = [
    ./hyprland.nix
    ./waybar.nix
    ];

    /* Notifications */
    services.swaync.enable = true;

    /* Wifi - use nmcli / nmtui otherwise */
    services.network-manager-applet.enable = true;
}
