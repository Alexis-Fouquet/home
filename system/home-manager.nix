{
  pkgs,
  username,
  userpath,
  ...
}:
{
  # This configuration should be portable
  home.username = username;
  home.homeDirectory = userpath;
  # Should not change
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
    # Trying to fix symbols size on waybar
    nerd-fonts.symbols-only
    # python313Packages.pylatexenc
  ];
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    # DISPLAY = ":1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.sessionPath = [
    # For Rust
    "$HOME/.cargo/bin"
  ];

  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetOptions = [
        "--preview 'ls {}'"
      ];
      fileWidgetOptions = [
        "--preview 'bat {} -r :10'"
      ];
    };
    zathura.enable = true;
    nh.enable = true;
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
    };
  };
}
