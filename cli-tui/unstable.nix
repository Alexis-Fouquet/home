{ ... }:
{
  # I may add unstable packages here
  # If needed, add unstable to imports
  home.packages = [ ];
  programs.television = {
    enable = true;
    channels = {
      nix = {
        metadata = {
          name = "nix";
          requirements = [
            "nix-search-tv"
          ];
        };
        source.command = "nix-search-tv print";
        preview.command = "nix-search-tv preview {}";
      };
    };
  };
}
