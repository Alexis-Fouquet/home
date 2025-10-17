{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    libqalculate
  ];

  programs.rofi = {
    enable = true;
  };
}
