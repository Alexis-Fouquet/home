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
    EDITOR = "vim";
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
