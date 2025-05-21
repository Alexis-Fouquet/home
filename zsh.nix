{ config, pkgs, lib, ... }:
{
    programs.zsh = {
        enable = true;
        autocd = true;
        zprof.enable = false;
        shellAliases = {
            vim = "nvim";
            ":q" = "exit";
            cat = "bat";
            icat = "kitten icat";
        };
        completionInit = "autoload -Uz compinit && compinit -C";
        antidote = {
            enable = true;
            plugins =
            [
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
            /* Syntax hightlighting */
            /* sh */
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
            /* sh */
            ''
# datenow
# echo "Start 2"
            '';
            after = lib.mkOrder 1000
            /* sh */
            ''
# datenow
if [[ ! $1 ]] && [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
    p10k_applied=true
fi
            '';
            in lib.mkMerge [early before after];
    };
}
