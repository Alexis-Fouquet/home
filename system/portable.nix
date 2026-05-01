{
  username,
  userpath,
  ...
}:
{
  # This configuration should be portable
  # Home manager does not need this on nixos
  # I put this only for non root / nixos systems
  home.username = username;
  home.homeDirectory = userpath;
}
