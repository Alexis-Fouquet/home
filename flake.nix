{
  # Made using the template on home-manager repository
  description = "Home Manager and NixOS configuration of Alexis Fouquet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wallpaper.url = "github:lunik1/nix-wallpaper";
    wallpkgs.url = "github:NotAShelf/wallpkgs";

    unstable-pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      unstable-pkgs,
      home-manager,
      nixvim,
      nix-flatpak,
      quickshell,
      nix-wallpaper,
      wallpkgs,
      ...
    }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = unstable-pkgs.legacyPackages.${system};
      extra =
        {
          username,
          userpath,
          on-nixos,
          at-epita,
        }:
        {
          nixvim = nixvim;
          flatpak = nix-flatpak;
          username = username;
          userpath = userpath;
          on-nixos = on-nixos;
          qs-pkg = quickshell.packages.${system}.default;
          nix-wallpaper = nix-wallpaper.packages.${system}.default;
          qs = true;
          debug = false;
          at-epita = at-epita;
          i3 = at-epita || on-nixos;
          unstable = unstable;
          wallpkgs = wallpkgs;
          grammar = pkgs.vimPlugins.nvim-treesitter.builtGrammars;
        };
      home =
        {
          username,
          userpath,
          on-nixos,
          at-epita,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./index.nix
          ];
          extraSpecialArgs = extra {
            username = username;
            userpath = userpath;
            on-nixos = on-nixos;
            at-epita = at-epita;
          };
        };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = extra {
                username = "alexisf";
                userpath = "/home/alexisf";
                on-nixos = true;
                at-epita = false;
              };
              users.alexisf = import ./index.nix;
            };
          }
        ];
      };
      homeConfigurations."${builtins.getEnv "USER"}" = home {
        username = builtins.getEnv "USER";
        userpath = builtins.getEnv "HOME";
        on-nixos = builtins.getEnv "USER" == "alexisf";
        at-epita = builtins.getEnv "USER" == "alexis.fouquet";
      };
    };
}
