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

