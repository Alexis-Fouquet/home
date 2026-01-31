{ pkgs, lib, ... }:
let
  use_ly = false;
  use_gdm = true;
in
{
  # Generated from the installer and edited after
  imports = [
    # Impure - generated per computer - impure even with a symlink
    ./hardware-configuration.nix
    ./gui/flatpak.nix
  ];

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr";
  # Only for gdm, does not activate xserver
  services.xserver.xkb.layout = "fr";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.displayManager.ly = {
    enable = use_ly;
  };

  services.xserver.enable = false;

  services.displayManager.gdm = {
    enable = use_gdm;
    wayland = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.alexisf = {
    isNormalUser = true;
    description = "Alexis Fouquet";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.firefox.enable = false;
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.hyprlock.enable = true;

  # Should restart after editing this
  systemd.user.services.hypridle = {
    path = [ pkgs.libnotify ];
  };

  services.flatpak.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  qt.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gnumake
    libnotify
    man-pages
    man-pages-posix
    nixfmt-rfc-style
  ];
  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "25.05"; # Did you read the comment? Yes

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nixpkgs.config.allowUnfreePredicate =
    p:
    builtins.elem (lib.getName p) [
    ];

  # TODO: find a way to add this in the dev flake
  virtualisation.docker.enable = true;

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };
}
