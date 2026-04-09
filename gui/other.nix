{ pkgs, zen-browser, unstable, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = [
    # Just to have Zotero 8
    unstable.zotero
    pkgs.obsidian
  ];

  programs.zen-browser.enable = true;
}
