{ nix-wallpaper, ... }:
{
    services.hyprpaper = {
        enable = true;
        settings = {
            splash = true;
            preload = [
            "${nix-wallpaper}/share/wallpapers/nixos-wallpaper.png"
            ];
        };
    };

    home.packages = [
    nix-wallpaper
    ];
}
