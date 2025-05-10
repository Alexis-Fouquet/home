{ config, pkgs, lib, ... }:
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
            /* shellIntegration.mode = null; */
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
        };
        zsh = {
            enable = true;
            autocd = true;
            zprof.enable = false;
            shellAliases = {
                vim = "nvim";
            };
            completionInit = "autoload -Uz compinit && compinit -C";
            antidote = {
                enable = true;
                plugins = [
                    "romkatv/powerlevel10k"
                    "getantidote/use-omz"
                    "ohmyzsh/ohmyzsh path:lib"
                    "ohmyzsh/ohmyzsh path:plugins/git"
                    "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
                    "zsh-users/zsh-autosuggestions"
                    "zsh-users/zsh-syntax-highlighting kind:defer"
                    "MichaelAquilina/zsh-you-should-use"
                ];
            };
            initContent =
            let early = lib.mkOrder 500
            ''
alias datenow="date +\"%s,%N\""

# datenow
INSTANT_PROMPT="''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
if [[ -r $INSTANT_PROMPT ]]; then
  source $INSTANT_PROMPT
fi

if [[ ! $1 ]] && [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
    p10k_applied=true
fi

# datenow
# echo "Start 1"
            '';
            before = lib.mkOrder 550
            ''
# datenow
# echo "Start 2"
            '';
            after = lib.mkOrder 1000
            ''
# datenow
if [[ ! $1 ]] && [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
    p10k_applied=true
fi
            '';
            in lib.mkMerge [early before after];
        };
    };
}
