{ hyprpanel, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
    ./home.nix
    ./wallpapers.nix
  ];

  # Notifications UI - disabled if managed by hyprpanel
  services.swaync.enable = !hyprpanel;
  # libnotify is placed in configuration.nix

  # Wifi - use nmcli / nmtui otherwise
  services.network-manager-applet.enable = true;
}
