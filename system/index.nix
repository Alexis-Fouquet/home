{
  lib,
  on-nixos,
  ...
}:
{
  imports = [
    ./home-manager.nix
    ./kitty.nix
  ]
  ++ lib.optionals on-nixos [
    ./git.nix
  ]
  ++ lib.optionals (!on-nixos) [
    ./portable.nix
  ];
}
