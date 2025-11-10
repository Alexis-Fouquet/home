{
  lib,
  on-nixos,
  at-epita,
  ...
}:
{
  imports = [
    ./home-manager.nix
    ./git.nix
    ./kitty.nix
  ]
  ++ lib.optionals on-nixos [
  ]
  ++ lib.optionals at-epita [
  ];
}
