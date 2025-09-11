{ pkgs, ... }:
{
    home.packages = with pkgs;
    [
        nerd-fonts.jetbrains-mono
        cbonsai
        libqalculate
        dict
    ];

    programs= {
        btop.enable = true;
        lazygit.enable = true;
    };
}
