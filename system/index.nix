{
  lib,
  on-nixos,
  ...
}:
{
  imports = [
    ./home-manager.nix
    ./git.nix
    ./kitty.nix
  ]
  ++ lib.optionals (!on-nixos) [
    ./portable.nix
  ];
}
