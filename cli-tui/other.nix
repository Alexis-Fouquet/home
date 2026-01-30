{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    libqalculate
    nix-search-tv
    asciinema
    rlwrap
    lf
  ];
}
