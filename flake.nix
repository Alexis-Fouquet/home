{
    /* Made using the template on home-manager repository */
    description = "Home Manager and NixOS configuration of Alexis Fouquet";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    };

    outputs =
    { nixpkgs, home-manager, nixvim, nix-flatpak, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        extra = {username, userpath, on-nixos}: {
                nixvim = nixvim;
                flatpak = nix-flatpak;
                username = username;
                userpath = userpath;
                on-nixos = on-nixos;
                waybar = true;
                hyprpanel = false;
                debug = false;
        };
        home = {username, userpath, on-nixos}:
        home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
            ./home-index.nix
            ];
            extraSpecialArgs = extra {
                username = username;
                userpath = userpath;
                on-nixos = on-nixos;
            };
        };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix

                nix-flatpak.nixosModules.nix-flatpak
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        extraSpecialArgs = extra {
                            username = "alexisf";
                            userpath = "/home/alexisf";
                            on-nixos = true;
                        };
                        users.alexisf = import ./home-index.nix;
                    };
                }
            ];
        };
        homeConfigurations.alexisf = home {
            username = "alexisf";
            userpath = "/home/alexisf";
            on-nixos = true;
        };
        homeConfigurations."${builtins.getEnv "USER"}" = home {
            username = builtins.getEnv "USER";
            userpath = builtins.getEnv "HOME";
            on-nixos = false;
        };
    };
}
