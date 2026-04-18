{
  pkgs,
  lib,
  game-mode,
  config,
  dms,
  ...
}:
{
  # Generated from the installer and edited after
  imports = [
    # Impure - generated per computer - impure even with a symlink
    ./hardware-configuration.nix
    dms.nixosModules.greeter
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

  services.xserver.enable = false;
  programs.xwayland.enable = true;

  services.greetd.enable = true;
  # From the documentation
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
  };

  services.printing.enable = true;

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

  programs.niri.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  qt.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gcc
    gnumake
    libnotify
    man-pages
    man-pages-posix
    nixfmt-rfc-style
    xwayland-satellite
  ];
  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "25.05";

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nixpkgs.config.allowUnfreePredicate =
    p:
    builtins.elem (lib.getName p) [
      "idea"
      "clion"
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-unwrapped"
      # I think I removed it like 3 times, but always come back to it
      "obsidian"
    ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  # Games config
  services.xserver.videoDrivers = lib.mkIf game-mode [
    "modesetting"
    "nvidia"
  ];
  hardware.graphics = lib.mkIf game-mode {
    enable = true;
  };
  hardware.nvidia = lib.mkIf game-mode {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # TODO: find a way to avoid hard coding this
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";

      offload.enable = true;
      offload.enableOffloadCmd = true;
    };
  };
  programs.steam = lib.mkIf game-mode {
    enable = true;
  };
  programs.gamemode = lib.mkIf game-mode {
    enable = true;
  };
  nixpkgs.config.cudaSupport = lib.mkIf game-mode true;
}
