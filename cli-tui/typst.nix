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
