{ nixvim, ... }:
{
    imports = [
        nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
        enable = true;

        colorschemes.catppuccin = {
            enable = true;
        };

        plugins = {
            telescope = {
                enable = true;
                autoLoad = true;
            };

            web-devicons.enable = true;

            wakatime.enable = true;
            neo-tree.enable = true;

            notify.enable = true;
        };
    };

}

