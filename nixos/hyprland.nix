{ pkgs, ... }:
{
    home.packages = with pkgs;
    [
    wofi
    ];

    services.hyprpaper.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
    };

    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        "$browser" = "firefox";
        "$terminal" = "kitty";
        "$menu" = "wofi --show drun";

        bind = [
        "$mod, B, exec, $browser"
        "$mod, D, exec, $menu"
        "$mod, T, exec, $terminal"
        "$mod, L, exec, hyprlock"
        "$mod, Q, killactive,"
        "$mod, E, exit,"
        "$mod, A, hyprexpo:expo, toggle"
        ]
        ++ (
                /* Half from the Hyprland documentation about Nix */
                builtins.concatLists (
                    builtins.genList (i:
                        let ws_id = i + 1;
                        key = toString i;
                        ws_name = toString ws_id;
                        in [
                        "$mod, code:1${key}, workspace, ${ws_name}"
                        "$mod SHIFT, code:1${key}, movetoworkspace, ${ws_name}"
                        ]
                        )
                    9)
           );

        exec-once = [
            "$terminal --hold zsh -c \"cbonsai -lim \"Hello!\"\""
        ];

        input = {
            kb_layout = "fr";

            touchpad = {
                natural_scroll = false;
                disable_while_typing = true;
            };
        };
    };

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins;
    [
        hyprexpo
    ];
}
