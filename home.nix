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
        lazygit.enable = true;
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
        kitty = {
            enable = true;
            font = {
                name = "FantasqueSansM Nerd Font Mono";
                size = 14.0;
            };
            themeFile = "Galaxy";
            enableGitIntegration = true;
            /* Will be changed later. */
            /* Need to configure zsh before with home-manager. */
            shellIntegration.mode = null;
            /*
            shellIntegration = {
                enableZshIntegration = true;
                mode = "enabled";
            };
            */
            settings = {
                enable_audio_bell = false;

                background_opacity = 0.9;
                dynamic_background_opacity = 1;
                confirm_os_window_close = 0;

                cursor_trail = 1;
                scrollback_lines = 1500;

                window_padding_width = 3;

                selection_foreground = "none";
                selection_background = "none";

                background = "#000000";
            };
        };
    };
}
