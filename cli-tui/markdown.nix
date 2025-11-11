{
  pkgs,
  at-epita,
  grammar,
  ...
}:
let
  diagrams = false && !at-epita;
in
{
  home.packages =
    with pkgs;
    [
      # For image.nvim
      luajitPackages.magick
    ]
    ++ lib.optionals diagrams [
      mermaid-cli
      plantuml
    ];

  programs.nixvim = {
    plugins = {
      obsidian = {
        enable = !at-epita;
        # TODO: detect repository
        lazyLoad.settings = {
          ft = "md";
        };
      };
      vimwiki = {
        # Breaks everything by changing the filetype
        enable = false;
        settings = {
          filetypes = [ "markdown" ];
        };
        # LazyLoad not yet implemented for this plugin
      };
      render-markdown = {
        enable = false;
        lazyLoad.settings = {
          ft = "markdown";
        };
      };
      markview = {
        enable = true;
        lazyLoad.settings = {
          ft = "markdown";
        };
      };

      image = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";
      };
      diagram = {
        enable = diagrams;
      };

      treesitter = {
        grammarPackages = with grammar; [
          markdown
          markdown_inline
        ];
      };
    };
  };
}
