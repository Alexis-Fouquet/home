{ ... }:
{
  imports = [
    ./hyprland.nix
    ./home.nix
    ./wallpapers.nix
  ];

  # libnotify is placed in configuration.nix
  # Wifi - use nmcli / nmtui otherwise
  services.network-manager-applet.enable = true;
}
