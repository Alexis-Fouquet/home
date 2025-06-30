{ nixvim, ... }:
{
    imports = [
        nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
        enable = false;
    };
}

