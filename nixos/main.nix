{ ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
    ./home.nix
    ./wallpapers.nix
  ];

  # libnotify is placed in configuration.nix
  # Wifi - use nmcli / nmtui otherwise
  services.network-manager-applet.enable = true;
}
