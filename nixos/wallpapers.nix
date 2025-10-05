{ nix-wallpaper, ... }:
let theme = (nix-wallpaper.override {
        preset = "gruvbox-dark";
        });
theme-path = "${theme}/share/wallpapers/nixos-wallpaper.png";
in {
    services.hyprpaper = {
        enable = true;
        settings = {
            splash = true;
            preload = [ theme-path ];
            wallpaper = [
            ", ${theme-path}"
            ];
        };
    };

    home.packages = [
    theme
    ];
}
