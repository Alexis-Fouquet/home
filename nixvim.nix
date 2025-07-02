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
            lualine.enable = true;
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
        };
    };
}

