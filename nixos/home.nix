{ pkgs, ... }:
{
    home.packages = with pkgs;
    [
        nerd-fonts.jetbrains-mono
        cbonsai
        libqalculate
        dict
        dust
        nix-tree
    ];

    programs= {
        btop.enable = true;
        lazygit.enable = true;
    };
}
