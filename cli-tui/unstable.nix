{ unstable, ... }:
{
  # I may add unstable packages here
  # If needed, add unstable to imports
  home.packages = [ ];
  programs.television = {
      enable = true;
      package = unstable.television;
      # Channels files are not working currently in 25.05
      # I need to create my own file
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
