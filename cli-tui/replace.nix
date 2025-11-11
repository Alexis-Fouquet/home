{ ... }:
{
  programs = {
    fd.enable = true;
    bat.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
