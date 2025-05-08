{ config, pkgs, ... }:
{
    home.username = "alexis";
    home.homeDirectory = "/home/alexis";
    /* Should not change */
    home.stateVersion = "24.11";

    home.packages = with pkgs;
    [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fantasque-sans-mono
    ];
    fonts.fontconfig.enable = true;

    home.file = {
    };

    home.sessionVariables = {
        EDITOR = "vim";
    };

    programs = {
        home-manager.enable = true;
        fastfetch.enable = true;
        zoxide = {
            enable = true;
            enableZshIntegration = true;
            options = ["--cmd cd"];
        };
        eza = {
            enable = true;
            enableZshIntegration = true;
            icons = "auto";
        };
    };
}
