{ lib, ... }:
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
      dev = "nix develop -c zsh";
      open = "xdg-open";
      gflags = "gcc -std=c99 -pedantic -Werror -Wall -Wextra -Wvla";
      st0 = "shutdown 0";
    };
    completionInit = "autoload -Uz compinit && compinit -C";
    enableCompletion = true;
    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
        "getantidote/use-omz"
        "ohmyzsh/ohmyzsh path:lib"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
        "ohmyzsh/ohmyzsh path:plugins/sudo"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting kind:defer"
        "MichaelAquilina/zsh-you-should-use"
      ];
    };
    initContent = lib.mkMerge [
      (lib.mkOrder 500
        # Early content
        # Syntax hightlighting
        /* sh */ ''
          alias datenow="date +\"%s,%N\""

          # datenow
          INSTANT_PROMPT="''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          if [[ -r $INSTANT_PROMPT ]]; then
              source $INSTANT_PROMPT
          fi


          # datenow
          # echo "Start 1"
        ''
      )
      # -------------------------------------------------------------------------
      (lib.mkOrder 550
        # Before
        /* sh */ ''
          # datenow
          # echo "Start 2"
        ''
      )
      # -------------------------------------------------------------------------
      (lib.mkOrder 1000
        # After
        /* sh */ ''
          if [[ -f ~/.p10k.zsh ]]; then
              source ~/.p10k.zsh
          fi
        ''
      )
      # -------------------------------------------------------------------------
      (lib.mkOrder 1500
        # End of file
        /* sh */ ''
          # datenow
        ''
      )
    ];
  };
}
