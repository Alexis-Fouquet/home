{
  # Made using the template on home-manager repository
  description = "Home Manager and NixOS configuration of Alexis Fouquet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-pkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "unstable-pkgs";
        home-manager.follows = "home-manager";
      };
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    unstable-pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpkgs.url = "github:NotAShelf/wallpkgs";
  };

  outputs =
    {
      nixpkgs,
      unstable-pkgs,
      home-manager,
      nixvim,
      wallpkgs,
      zen-browser,
      nix-index-database,
      stable-pkgs,
      ...
    }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = unstable-pkgs.legacyPackages.${system};
      stable = stable-pkgs.legacyPackages.${system};
      extra =
        {
          username,
          userpath,
          on-nixos,
          at-epita,
          game-mode,
        }:
        {
          nixvim = nixvim;
          username = username;
          userpath = userpath;
          on-nixos = on-nixos;
          qs = on-nixos;
          debug = false;
          at-epita = at-epita;
          i3 = at-epita || on-nixos;
          unstable = unstable;
          wallpkgs = wallpkgs;
          grammar = pkgs.vimPlugins.nvim-treesitter.builtGrammars;
          zen-browser = zen-browser;
          game-mode = game-mode;
          nix-index-database = nix-index-database;
          stable = stable;
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
            game-mode = false;
          };
        };
    in
    {
      nixosConfigurations.nixos =
        let
          ext = extra {
            username = "alexisf";
            userpath = "/home/alexisf";
            on-nixos = true;
            at-epita = false;
            game-mode = builtins.getEnv "GAMES" == "enabled";
          };
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = ext;
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = ext;
                users.alexisf = import ./index.nix;
              };
            }
          ];
        };
      homeConfigurations."${builtins.getEnv "USER"}" = home {
        username = builtins.getEnv "USER";
        userpath = builtins.getEnv "HOME";
        at-epita = builtins.getEnv "USER" == "alexis.fouquet";
        on-nixos = false;
      };
    };
}
