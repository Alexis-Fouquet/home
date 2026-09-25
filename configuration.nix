{
  pkgs,
  lib,
  game-mode,
  config,
  dms-plugin-registry,
  ...
}:
{
  # Generated from the installer and edited after
  imports = [
    # Impure - generated per computer - impure even with a symlink
    ./hardware-configuration.nix
    dms-plugin-registry.nixosModules.default
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
  boot.loader.timeout = 1;

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

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;

    plugins = {
        dockerManager.enable = true;
        dankPomodoroTimer.enable = true;
        # TODO: enable when fixed
        dankBatteryAlerts.enable = false;
        wallpaperCarousel.enable = true;
    };
  };

  services.paperless = {
    enable = false;
    # OpenCV takes 1h to compile, keep stable instead
    # package = stable.paperless-ngx;
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        "*.csv"
        "*.ipynb"
        "*.py"
        "*.html"
        "*.xpi"
      ];
      PAPERLESS_CONSUMER_DELETE_DUPLICATES = true;
    };
  };
  fileSystems."/home/alexisf/paperless" = {
    fsType = "none";
    device = "/var/lib/paperless/media/documents/archive";
    options = [
      "bind"
      "ro"
      "nofail"
    ];
  };

  # From the documentation
  services.greetd.enable = true;
  services.displayManager.dms-greeter = {
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

  users.users = {
    alexisf = {
      isNormalUser = true;
      description = "Alexis Fouquet";
      extraGroups = [
        "networkmanager"
        "wheel"
        "paperless"
      ];
    };
    games = {
      isNormalUser = true;
      description = "User for games and anything not related to work";
      extraGroups = [
        "networkmanager"
      ];
    };
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
    nixfmt
    xwayland-satellite
    dgop
    xdg-terminal-exec
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
      # I think I removed it like 3 times, but always come back to it
      "obsidian"

      # Games
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-unwrapped"
      "nvidia-kernel-modules"

      # CUDA compiling
      "cuda_cudart"
      "cuda_nvcc"
      "cuda_cccl"
      "libnpp"
      "libcublas"
      "libcufft"
      "cuda_cupti"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "libcufile"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libcusparse_lt"
      "cudnn"
      "cuda_profiler_api"
      "cuda_cuobjdump"
      "cuda_nvdisasm"
      "cuda-merged"
      "cuda_gdb"
      "cuda_nvprune"
      "cuda_cuxxfilt"
      "cuda_sanitizer_api"
    ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    enableOnBoot = false;
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

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
  programs.gamescope = lib.mkIf game-mode {
    enable = true;
  };
  programs.steam = lib.mkIf game-mode {
    enable = true;
  };
  programs.gamemode = lib.mkIf game-mode {
    enable = true;
  };
  nixpkgs.config.cudaSupport = lib.mkIf game-mode true;
}
