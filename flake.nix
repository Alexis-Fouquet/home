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
            url = "github:Alexis-Fouquet/NeovimConfig";
            flake = false;
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
    { nixpkgs, home-manager, neovim-config, nixvim, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        homeConfigurations."${builtins.getEnv "USER"}" =
        home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./home.nix
                ./zsh.nix
                ./nixvim.nix
            ];
            extraSpecialArgs = {
                neovim-config = neovim-config;
                nixvim = nixvim;
            };
        };
    };
}
