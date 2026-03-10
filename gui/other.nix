{ pkgs, zen-browser, unstable, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = [
    pkgs.jetbrains.idea
    # Just to have Zotero 8
    unstable.zotero
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
