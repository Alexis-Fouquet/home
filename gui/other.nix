{ pkgs, zen-browser, unstable, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = [
    pkgs.jetbrains.idea
    pkgs.jetbrains.clion
    # Just to have Zotero 8
    unstable.zotero
    pkgs.obsidian
  ];

  programs.zen-browser.enable = true;
  programs.sioyek = {
    enable = false;
    bindings = {
      move_left = "H";
      move_right = "L";
    };
  };
}
