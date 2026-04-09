{
  pkgs,
  at-epita,
  grammar,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      # For image.nvim
      luajitPackages.magick
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
          ft = ["markdown"];
        };
      };

      image = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";
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
