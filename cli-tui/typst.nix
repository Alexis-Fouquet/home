{
  grammar,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    typst
  ];

  programs.nixvim = {
    plugins = {
      typst-preview.enable = true;
      markview = {
        # Surprise of 2025-12-12: this plugin also works for typst
        # I was just lazy loading it only for markdown...
        enable = true;
        lazyLoad.settings = {
          ft = ["typst"];
        };
      };
      treesitter = {
        grammarPackages = with grammar; [
          typst
        ];
      };
    };
    lsp.servers = {
      tinymist.enable = true;
    };
  };
}
