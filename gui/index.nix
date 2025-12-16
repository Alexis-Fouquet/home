{
  lib,
  on-nixos,
  at-epita,
  qs,
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
  ]
  ++ lib.optionals qs [
    ./qs.nix
  ];
}
