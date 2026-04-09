{
  lib,
  on-nixos,
  qs,
  ...
}:
{
  imports = [
    ./rofi.nix
  ]
  ++ lib.optionals on-nixos [
    ./other.nix
  ]
  ++ lib.optionals qs [
    ./qs.nix
  ];

  xdg.configFile = {
    "niri/config.kdl" = {
        source = ./config.kdl;
    };
  };
}
