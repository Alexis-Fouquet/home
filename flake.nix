{
    /* Made using the template on home-manager repository */
    description = "Home Manager configuration of Alexis Fouquet";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        neovim-config = {
            url = "git+file:NeovimConfig";
            flake = false;
        };
    };

    outputs =
    { nixpkgs, home-manager, self, neovim-config, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        neovimPath = self + "/NeovimConfig";
    in
    {
        homeConfigurations."${builtins.getEnv "USER"}" =
        home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./home.nix
                ./zsh.nix
            ];
            extraSpecialArgs = {
                self = self;
                neovim-config = neovim-config;
            };
        };
    };
}
