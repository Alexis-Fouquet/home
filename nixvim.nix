{ nixvim, lib, ... }:
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
            lz-n.enable = true;

            which-key = {
                enable = true;
                lazyLoad.settings.event = "DeferredUIEnter";
            };
            telescope = {
                enable = true;
                extensions.fzf-native.enable = true;
                lazyLoad.settings = {
                    cmd = "Telescope";
                };
            };

            wakatime.enable = true;
            neo-tree.enable = true;

            web-devicons.enable = true;
            notify.enable = true;
            smear-cursor.enable = true;
            lualine.enable = true;

            fugitive = {
                enable = true;
            };
            gitsigns.enable = true;

            obsidian = {
                enable = false;
                lazyLoad.settings = {
                    ft = "md";
                };
            };
            vimwiki = {
                enable = false;
            };
            render-markdown = {
                enable = false;
                lazyLoad.settings = {
                    ft = "md";
                };
            };

            nvim-autopairs = {
                enable = true;
                lazyLoad.settings.event = "BufEnter";
            };

            nui.enable = true;
            treesitter.enable = true;

            image.enable = true;

            lspconfig.enable = true;

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

            /* Some of them are directly from the documentation */
            keymaps = [
            {
                key = "gd";
                lspBufAction = "definition";
            }
            {
                key = "gD";
                lspBufAction = "references";
            }
            {
                key = "gt";
                lspBufAction = "type_definition";
            }
            {
                key = "gi";
                lspBufAction = "implementation";
            }
            {
                key = "gK";
                lspBufAction = "hover";
            }
            {
                action =
                    lib.nixvim.mkRaw
                    "function() vim.diagnostic.jump({ count=-1, float=true }) end";
                key = "<leader>k";
            }
            {
                action =
                    lib.nixvim.mkRaw
                    "function() vim.diagnostic.jump({ count=1, float=true }) end";
                key = "<leader>j";
            }
            ];
        };

        diagnostic.settings = {
            virtual_lines = {
                current_line = true;
            };

            virtual_text = true;
        };

        performance = {
            byteCompileLua.enable = true;
            combinePlugins.enable = true;
        };

        globals.mapleader = " ";

        keymaps = [
            {
                action = ":Telescope";
                key = "<leader><leader>";
            }
        ];
    };
}

