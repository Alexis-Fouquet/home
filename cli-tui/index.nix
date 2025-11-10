{
  lib,
  on-nixos,
  at-epita,
  userpath,
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

  home.file = {
    "${userpath}/.config/nvim/snippets" = {
      source = ./nixvim/snippets;
      recursive = true;
    };
    "${userpath}/.config/television/cable/nix-search-tv-fixed.toml" = {
      source = ./nix.toml;
    };
  };

  home.sessionPath = [
    "${./scripts}"
  ];
}
