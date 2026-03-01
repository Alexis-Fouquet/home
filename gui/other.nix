{ pkgs, zen-browser, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = with pkgs; [
    jetbrains.idea
    obsidian
    zotero
  ];

  programs.zen-browser.enable = true;
  programs.sioyek = {
    enable = true;
    bindings = {
      move_left = "H";
      move_right = "L";
    };
  };
}
