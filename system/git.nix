{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      # Inspired by a command on stackoverflow
      adog = "log --all --decorate --oneline --graph";
    };
    lfs.enable = true;
    userName = "Alexis Fouquet";
    # Public email for github
    userEmail = "144385093+Alexis-Fouquet@users.noreply.github.com";
    signing = {
      format = "ssh";
    };
  };
}
