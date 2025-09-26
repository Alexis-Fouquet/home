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
        /* TODO: find integrations and CLI apps */
        anki
    ];

    programs = {
        btop.enable = true;
        lazygit.enable = true;
    };
}
