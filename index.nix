{
  lib,
  on-nixos,
  at-epita,
  nix-index-database,
  ...
}:
{
  imports = [
    nix-index-database.homeModules.default
    ./system/index.nix
    ./cli-tui/index.nix
    ./gui/index.nix
  ]
  ++ lib.optionals on-nixos [
    ./nixos/main.nix
  ]
  ++ lib.optionals at-epita [
    ./epita/epita.nix
  ];
}
