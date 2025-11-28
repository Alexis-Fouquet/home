{ ... }:
{
  # Home-manager option not yet available in 25.05
  home.packages = [
  ];

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };
}
