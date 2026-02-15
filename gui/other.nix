{ pkgs, zen-browser, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = with pkgs; [
    jetbrains.idea
    # xwayland
  ];

  programs.zen-browser.enable = true;
}
