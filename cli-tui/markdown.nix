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
