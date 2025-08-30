{ pkgs, ... }:
{
    /* Generated from the installer and edited after */
    imports =
        [
        /* Impure - generated per computer - impure even with a symlink */
        ./hardware-configuration.nix
        ./flatpak.nix
        ];

    /* Enable bluetooth */
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Experimental = true;
            };
        };
    };

    /* Bootloader */
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "en_US.UTF-8";

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

    /* TODO: as I use Hyprland, I should switch gdm to wayland */
    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    /* Only used for installation */
    services.xserver.desktopManager.gnome.enable = false;

    services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
    };

    console.keyMap = "fr";
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
        extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.firefox.enable = true;
    programs.hyprland.enable = true;
    programs.hyprlock.enable = true;

    systemd.services.hypridle = {
        path = [ pkgs.libnotify ];
    };

    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        gnumake
        libnotify
    ];

    system.stateVersion = "25.05"; /* Did you read the comment? Yes */

    nix.gc = {
        automatic = true;
        dates = "weekly";
    };
}
