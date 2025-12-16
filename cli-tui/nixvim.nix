{
  nixvim,
  lib,
  grammar,
  on-nixos,
  at-epita,
  debug,
  ...
}:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.ripgrep.enable = true;

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
      lualine.enable = true;

      fugitive = {
        enable = true;
        # LazyLoad not yet implemented for this plugin
      };
      gitsigns.enable = true;

      vimtex.enable = !at-epita;

      nvim-snippets = {
        enable = true;
        settings = {
          /*
            Too slow, look at this later
            extended_filetypes = {
                markdown = [ "tex" "latex" ];
            };
          */
          friendly_snippets = false;
          create_cmp_source = true;
        };
      };

      nvim-autopairs = {
        enable = true;
        lazyLoad.settings.event = "BufEnter";
      };

      treesitter = {
        enable = true;

        grammarPackages = with grammar; [
          rust
          lua
          nix
          latex
          python
          java
          qmljs
          c
          sql
        ];

        settings = {
          highlight.enable = true;
        };
      };

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
            { name = "snippets"; }
            # Commented to avoid auto install
            # { name = "luasnip"; }
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<S-Tab>" = /* lua */ ''
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
            "<Tab>" = /* lua */ ''
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
            __raw = /* lua */ ''
              {
                  completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
              }
            '';
            completion = {
              __raw = nixvim.lib.nixvim.mkRaw "cmp.config.window.bordered()";
            };
            documentation.border = [
              "/"
              "-"
              "\\"
              "|"
            ];
          };

          snippet.expand = /* lua */ ''
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
            format = lib.mkForce /* lua */ ''
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

        # Was not a good idea
        # lazyLoad.settings.event = "BufEnter";
      };
      lspkind = {
        enable = true;
        # LazyLoad not yet implemented for this plugin
        # lazyLoad.settings.event = "BufEnter";
      };
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

      mouse = "";
    };

    lsp = {
      inlayHints.enable = true;

      servers = {
        nixd = {
          enable = true;
          settings.settings.nixd.formatting = {
            command = "nixfmt --width 80";
          };
        };
        clangd.enable = true;
        rust_analyzer.enable = true;
        texlab.enable = true;
        qmlls.enable = true;

        # Testing python
        ruff.enable = false;
        pylsp.enable = false;
        # With a z this is better
        pylyzer.enable = false;
        pyright.enable = true;

        jdtls.enable = true;
      };

      # Some of them are directly from the documentation
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          action =
            nixvim.lib.nixvim.mkRaw
              # lua
              ''
                require('telescope.builtin').lsp_references
              '';
        }
        {
          key = "gF";
          lspBufAction = "format";
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
              # lua
              ''
                function() vim.diagnostic.jump({ count=-1, float=true }) end
              '';
          key = "<leader>k";
        }
        {
          action =
            nixvim.lib.nixvim.mkRaw
              # lua
              ''
                function() vim.diagnostic.jump({ count=1, float=true }) end
              '';
          key = "<leader>j";
        }
      ];
    };

    diagnostic.settings = {
      virtual_lines = false;
      virtual_text = true;
    };

    performance = {
      byteCompileLua.enable = debug;
      combinePlugins.enable = true;
      combinePlugins.standalonePlugins = [
        "friendly-snippets"
      ];
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
      {
        action = ":make";
        key = "<leader>m";
      }
      {
        action = ":!clang-format -i %";
        key = "<leader>c";
      }
    ]
    ++
      builtins.map
        (str: {
          action = "<nop>";
          key = str;
          mode = [ "n" ];
        })
        [
          "<Left>"
          "<Right>"
          "<Up>"
          "<Down>"
        ];

    clipboard.providers.wl-copy.enable = on-nixos;
    clipboard.providers.xclip.enable = at-epita;

    extraConfigLua = /* lua */ ''
      -- There might be a better way to do it
      vim.cmd("packadd termdebug");
    '';
  };
}
