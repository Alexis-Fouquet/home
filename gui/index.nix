{
  lib,
  on-nixos,
  at-epita,
  ...
}:
{
  imports = [
    ./rofi.nix
  ]
  ++ lib.optionals on-nixos [
    # Should not include flatpak
  ]
  ++ lib.optionals at-epita [
    ./i3.nix
  ];
}
