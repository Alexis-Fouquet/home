{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # TODO: why I have this?
    nerd-fonts.jetbrains-mono
    cbonsai
    nix-tree
    godot-mono
    # TODO: find integrations and CLI apps
    anki
  ];

  programs = {
    btop.enable = true;
    lazygit.enable = true;
  };
}
