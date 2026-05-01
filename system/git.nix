{ config, ... }:
let
  isMainUser = config.home.username == "alexisf";
  name = if isMainUser then "Alexis Fouquet" else "Alexis";
  email = if isMainUser then "144385093+Alexis-Fouquet@users.noreply.github.com" else "";
in
{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        # Inspired by a command on stackoverflow
        adog = "log --all --decorate --oneline --graph";
      };
      # Public email for github
      user.email = email;
      user.name = name;
      core.editor = "nvim";
    };
    lfs.enable = true;
    signing = {
      format = "ssh";
    };
  };
}
