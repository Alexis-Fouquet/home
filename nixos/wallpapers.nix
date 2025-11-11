{ nix-wallpaper, wallpkgs, ... }:
let
  theme = (
    nix-wallpaper.override {
      preset = "catppuccin-mocha";
    }
  );
  theme-path = "${theme}/share/wallpapers/nixos-wallpaper.png";
  # A wallpaper from the collection wallpkgs
  # See https://github.com/NotAShelf/wallpkgs for License
  wallpaper = wallpkgs.wallpapers.tokyo-night.tokyo_night-03.path;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      preload = [
        theme-path
        wallpaper
      ];
      wallpaper = [
        ", ${wallpaper}"
      ];
    };
  };

  home.packages = [
    theme
  ];
}
