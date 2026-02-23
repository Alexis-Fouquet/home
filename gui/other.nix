{ pkgs, zen-browser, ... }:
{
  imports = [
    zen-browser.homeModules.beta
  ];

  home.packages = with pkgs; [
    jetbrains.idea
  ];

  programs.zen-browser.enable = true;
  programs.sioyek = {
    enable = true;
    bindings = {
      move_left = "h";
      move_right = "l";
    };
  };
}
