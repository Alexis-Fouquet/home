{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea
    # xwayland
  ];
}
