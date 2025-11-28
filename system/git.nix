{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      aliases = {
        # Inspired by a command on stackoverflow
        adog = "log --all --decorate --oneline --graph";
      };
      # Public email for github
      user.email = "144385093+Alexis-Fouquet@users.noreply.github.com";
      user.name = "Alexis Fouquet";
      core.editor = "nvim";
    };
    lfs.enable = true;
    signing = {
      format = "ssh";
    };
  };
}
