{ nixvim, lib, pkgs, ... }:
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
                    cmd = [
                    "Telescope"
                    ];
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
            treesitter = {
                enable = true;

                grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                    rust
                    lua
                    nix
                    markdown
                    markdown_inline
                ];

                settings = {
                    highlight.enable = true;
                };
            };

            image.enable = true;

            lspconfig.enable = true;

            cmp = {
                enable = true;
                autoEnableSources = true;
                settings = {
                    sources = [
                    { name = "nvim_lsp"; }
                    { name = "path"; }
                    { name = "buffer"; }
                    { name = "calc"; }
                    ];

                    mapping = {
                        "<C-Space>" = "cmp.mapping.complete()";
                        "<S-Tab>" =
                            /* lua */
                            ''
                            cmp.mapping(function (fallback)
                                if cmp.visible() then
                                    cmp.select_next_item({
                                        behavior = cmp.SelectBehavior.Select
                                    })
                                else
                                    fallback()
                                end
                            end, {'i', 's', 'c'})
                            '';
                        "<C-e>" = "cmp.mapping.abort()";
                        "<Tab>" =
                            /* lua */
                            ''
                            cmp.mapping(function(fallback)
                                -- From the wiki
                                if cmp.visible() then
                                    local entry = cmp.get_selected_entry()
                                    if not entry then
                                        cmp.select_next_item({
                                            behavior = cmp.SelectBehavior.Select
                                        })
                                    end
                                    cmp.confirm()
                                else
                                    fallback()
                                end
                            end, {'i','s','c',})
                            '';
                    };

                    window = {
                        __raw =
                            /* lua */
                            ''
                            {
                                completion = cmp.config.window.bordered(),
                                documentation = cmp.config.window.bordered(),
                            }
                            '';
                        completion = {
                            __raw =
                                nixvim.lib.nixvim.mkRaw
                                "cmp.config.window.bordered()";
                        };
                        documentation.border = [
                            "/"
                            "-"
                            "\\"
                            "|"
                        ];
                    };

                    snippet.expand =
                        /* lua */
                        ''
                        function(args)
                            vim.snippet.expand(args.body)
                        end
                        '';

                    formatting = {
                        fields = [
                            "kind"
                            "abbr"
                            "menu"
                        ];
                        format =
                            /* lua */
                            lib.mkForce ''
                            function(entry, vim_item)
                                local kind = require("lspkind")
                                    .cmp_format({
                                        mode = "symbol_text",
                                        maxwidth = 60,
                                    })(entry, vim_item)
                                local strings = vim.split(
                                    kind.kind,
                                    "%s",
                                    { trimempty = true }
                                )
                                kind.kind = " " .. (strings[1] or "") .. " "
                                kind.menu = "    (" .. (strings[2] or "") .. ")"

                                return kind
                            end
                            '';
                    };

                };
                cmdline = {
                    "/" = {
                        sources = [
                        { name = "buffer"; }
                        ];
                    };
                    ":" = {
                        sources = [
                        { name = "path"; }
                        { name = "cmdline"; }
                        ];
                    };
                };

                # luaConfig.post =
                #     /* lua */
                #     ''
                #     cmp.setup.window({
                #         completion = cmp.config.window.bordered(),
                #         documentation = cmp.config.window.bordered(),
                #     })
                #     '';
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
                rust_analyzer = {
                    enable = true;
                };
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
                    nixvim.lib.nixvim.mkRaw
                    "function() vim.diagnostic.jump({ count=-1, float=true }) end";
                key = "<leader>k";
            }
            {
                action =
                    nixvim.lib.nixvim.mkRaw
                    "function() vim.diagnostic.jump({ count=1, float=true }) end";
                key = "<leader>j";
            }
            ];
        };

        diagnostic.settings = {
            virtual_lines = false;
            virtual_text = true;
        };

        performance = {
            byteCompileLua.enable = true;
            combinePlugins.enable = true;
        };

        globals.mapleader = " ";

        keymaps = [
        {
            action = ":Telescope find_files<CR>";
            key = "<leader><leader>";
        }
        {
            action = ":Telescope live_grep<CR>";
            key = "<leader>g";
        }
        ];
    };
}

