{ ... }:
{
    programs.kitty = {
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
}
