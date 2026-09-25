{ wallpkgs, lib, ... }:
let
  # A wallpaper from the collection wallpkgs
  # See https://github.com/NotAShelf/wallpkgs for License
  wallpaper = wallpkgs.wallpapers.tokyo-night.tokyo_night-03.path;
  specific = {
    cat-4 = wallpkgs.wallpapers.catppuccin.catppuccin-04;
    cat-1 = wallpkgs.wallpapers.catppuccin.catppuccin-01;
    cat-3d = wallpkgs.wallpapers.catppuccin.catppuccin-3d-model;
    cat-at = wallpkgs.wallpapers.catppuccin.catppuccin-abandoned-trainstation;
    cat-as = wallpkgs.wallpapers.catppuccin.catppuccin-abstract-swirls;
    cat-astro = wallpkgs.wallpapers.catppuccin.catppuccin-astronaut;
    cat-atl = wallpkgs.wallpapers.catppuccin.catppuccin-atlantis;
  };
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

  home.file =
    lib.attrsets.concatMapAttrs
      (name: value: {
        ".wallpapers/${name}.png".source = value.path;
      })
      (
        lib.attrsets.mergeAttrsList [
          wallpkgs.wallpapers.tokyo-night
          wallpkgs.wallpapers.space
          specific
        ]
      );
}
