{
  nixvim,
  grammar,
  on-nixos,
  at-epita,
  debug,
  pkgs,
  ...
}:
{
  imports = [
    nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.wakatime-cli
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
        enable = false;
        settings = {
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
        ];

        settings = {
          highlight.enable = true;
        };
      };

      lspconfig.enable = true;
      no-neck-pain.enable = true;
      csvview.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          # Inspired from documentation example
          completion = {
            accept = {
              auto_brackets = {
                enabled = true;
                semantic_token_resolution = {
                  enabled = false;
                };
              };
            };
            documentation = {
              auto_show = true;
            };
            ghost_text.enabled = true;
          };
          keymap = {
            preset = "super-tab";
          };
          signature = {
            enabled = true;
          };
        };
      };
    };

    opts = {
      autoindent = true;
      smartindent = true;
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;

      scrolloff = 6;
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
          config.settings.nixd.formatting = {
            command = "nixfmt --width 80";
          };
        };
        clangd.enable = true;
        rust_analyzer.enable = true;
        texlab.enable = true;
        qmlls = {
          enable = true;
          config.cmd = [
            "qmlls"
            "-E"
          ];
        };

        # Testing python
        ruff.enable = false;
        pylsp.enable = false;
        # With a z this is better
        pylyzer.enable = false;
        pyright.enable = true;

        jdtls.enable = true;

        asm_lsp.enable = true;
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
        "blink.cmp"
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
      map
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
