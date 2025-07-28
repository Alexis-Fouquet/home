{ ... }:
{
    imports = [
    ./hyprland.nix
    ./waybar.nix
    ];

    /* Notifications */
    services.swaync.enable = true;
}
