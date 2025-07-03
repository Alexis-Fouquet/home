{ nixvim, ... }:
{
    imports = [
        nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim = {
        enable = true;

        colorschemes.tokyonight = {
            enable = true;
        };

        plugins = {
            which-key.enable = true;
            telescope = {
                enable = true;
                extensions.fzf-native.enable = true;
            };

            wakatime.enable = true;
            neo-tree.enable = true;

            web-devicons.enable = true;
            notify.enable = true;
            smear-cursor.enable = true;
            /* easymotion.enable = true; */
            lualine.enable = true;

            fugitive.enable = true;
            gitsigns.enable = true;

            obsidian.enable = false;
            vimwiki.enable = false;
            render-markdown.enable = false;

            nvim-autopairs.enable = true;

            nui.enable = true;
            treesitter.enable = true;

            image.enable = true;

            lspconfig.enable = true;
            /* mason-lspconfig.enable = true; */
            /* mason.enable = true; */

            cmp = {
                enable = true;
                autoEnableSources = true;
                settings.sources = [
                    { name = "nvim_lsp"; }
                    { name = "path"; }
                    { name = "buffer"; }
                    { name = "cmdline"; }
                    { name = "calc"; }
                ];
            };
            lspkind.enable = true;
        };

        opts = {
            autoindent = true;
            smartindent = true;
            expandtab = true;
            shiftwidth = 4;
            tabstop = 4;

            colorcolumn = "80";
            signcolumn = "yes";
            cursorline = true;
            ruler = true;
            relativenumber = true;
            number = true;

            ignorecase = true;
            smartcase = true;

            conceallevel = 2;

            list = true;
            listchars = {
                tab = ">~";
                trail = "~";
            };

            splitbelow = true;
            splitright = true;
        };

        lsp = {
            inlayHints.enable = false;

            servers = {
                nixd.enable = true;
                clangd.enable = true;
                rust_analyser.enable = true;
            };
        };
    };
}

