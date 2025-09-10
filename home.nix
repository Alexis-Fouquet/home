{ pkgs, lib, username, userpath, on-nixos, ... }:
{
    /* This configuration should be portable */
    home.username = username;
    home.homeDirectory = userpath;
    /* Should not change */
    home.stateVersion = "24.11";

    imports = lib.optionals on-nixos
    [
    ./nixos/main.nix
    ];

    home.file = {
        "${userpath}/.config/nvim/snippets" = {
            source = ./nixvim/snippets;
            recursive = true;
        };
    };

    home.packages = with pkgs;
    [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fantasque-sans-mono
        cbonsai
        asciinema
        /* For image.nvim */
        luajitPackages.magick
        libqalculate
        dict
    ];
    fonts.fontconfig.enable = true;

    home.sessionVariables = {
        EDITOR = "vim";
    };

    home.sessionPath =
    [
        /* For Rust */
        "$HOME/.cargo/bin"
    ];

    programs = {
        home-manager.enable = true;
        fastfetch.enable = true;
        lazygit.enable = true;
        bat.enable = true;
        btop.enable = true;
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
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
            shellIntegration = {
                enableZshIntegration = true;
                mode = "enabled";
            };
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

                shell = "zsh";
            };
        };
        git = {
            enable = true;
            aliases = {
                /* Inspired by a command on stackoverflow */
                adog = "log --all --decorate --oneline --graph";
            };
            lfs.enable = true;
            userName = "Alexis Fouquet";
            /* Public email for github */
            userEmail = "144385093+Alexis-Fouquet@users.noreply.github.com";
            signing = {
                format = "ssh";
            };
        };
        neovim = {
            enable = false;
            /* Line from the image.nvim README, needed to run the plugin */
            extraLuaPackages = ps: [ ps.magick ];
        };
   };
}
