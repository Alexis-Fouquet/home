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

  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
    };
    nix-index = {
        enable = true;
        enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;
  };
}
