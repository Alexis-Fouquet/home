{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    libqalculate
    nix-search-tv
    asciinema
    rlwrap
    matugen
    cava
  ];

  programs.tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
  };
}
