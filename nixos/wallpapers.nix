{ wallpkgs, ... }:
let
  # A wallpaper from the collection wallpkgs
  # See https://github.com/NotAShelf/wallpkgs for License
  wallpaper = wallpkgs.wallpapers.tokyo-night.tokyo_night-03.path;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
        }
      ];
    };
  };
}
