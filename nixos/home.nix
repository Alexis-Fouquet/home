{ pkgs, ... }:
{
    home.packages = with pkgs;
    [
        nerd-fonts.jetbrains-mono
        cbonsai
        dict
        nix-tree
        godot-mono
        /* TODO: find integrations and CLI apps */
        anki
    ];

    programs = {
        btop.enable = true;
        lazygit.enable = true;
    };
}
