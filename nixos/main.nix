{ pkgs, ... }:
{
    imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
    ];

    /* Notifications */
    services.swaync.enable = true;
    home.packages = with pkgs;
    [
    libnotify
    ];

    /* Wifi - use nmcli / nmtui otherwise */
    services.network-manager-applet.enable = true;
}
