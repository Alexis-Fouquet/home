{ lib, on-nixos, i3, ... }:
{
    imports = [
        ./home.nix
        ./zsh.nix
        ./nixvim.nix
    ] ++ lib.optionals on-nixos
    [
    ./nixos/main.nix
    ] ++ lib.optionals i3 [
    ./epita/i3.nix
    ];
}
