{
  pkgs,
  # at-epita,
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
        enable = false;
        lazyLoad.settings = {
          ft = "md";
        };
      };

      image = {
        enable = false;
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
