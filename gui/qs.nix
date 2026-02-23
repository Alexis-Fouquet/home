{ dms, pkgs, dgop, ... }:
{
  imports = [
    dms.homeModules.dank-material-shell
  ];

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  programs.dank-material-shell = {
      enable = true;
      systemd.enable = true;
      enableSystemMonitoring = true;
      dgop.package = dgop.packages.${pkgs.system}.default;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
  };
}
