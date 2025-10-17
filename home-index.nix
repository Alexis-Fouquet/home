{
  lib,
  on-nixos,
  at-epita,
  ...
}:
{
  imports = [
    ./home.nix
    ./zsh.nix
    ./nixvim.nix
  ]
  ++ lib.optionals on-nixos [
    ./nixos/main.nix
    ./custom/apps.nix
  ]
  ++ lib.optionals at-epita [
    ./epita/epita.nix
    ./custom/apps.nix
  ];
}
