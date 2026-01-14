{
  lib,
  on-nixos,
  at-epita,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./nixvim.nix
    ./markdown.nix
    ./typst.nix
    ./unstable.nix
    ./replace.nix
  ]
  ++ lib.optionals on-nixos [
    ./other.nix
  ]
  ++ lib.optionals at-epita [
    ./other.nix
  ];

  xdg.configFile = {
    "nvim/snippets" = {
      source = ./nixvim/snippets;
      recursive = true;
    };
    "television/cable/nix-search-tv-fixed.toml" = {
      source = ./nix.toml;
    };
  };

  home.sessionPath = [
    "${./scripts}"
  ];
}
