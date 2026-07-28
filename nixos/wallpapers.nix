{ wallpkgs, ... }:
let
  # A wallpaper from the collection wallpkgs
  # See https://github.com/NotAShelf/wallpkgs for License
  wallpaper = wallpkgs.wallpapers.tokyo-night.tokyo_night-03.path;
  wallpaper2 = wallpkgs.wallpapers.tokyo-night.tokyo_night-02.path;
  wallpaper1 = wallpkgs.wallpapers.tokyo-night.tokyo_night-01.path;
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

  home.file.".wallpapers/wall.png".source = wallpaper;
  home.file.".wallpapers/wall2.png".source = wallpaper2;
  home.file.".wallpapers/wall1.png".source = wallpaper1;
}
