{ pkgs, ... }:
let mod = "SUPER";
alt = "SHIFT";
alt2 = "CTRL";
browser = "firefox";
terminal = "kitty";
drun = "wofi --show drun";
in {
    home.packages = with pkgs;
    [
    wofi
    nautilus
    ];

    services.hyprpaper.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
    };

    wayland.windowManager.hyprland.settings = {
        "$menu" = "wofi --show drun";

        bind = [
        "${mod}, B, exec, ${browser}"
        "${mod}, D, exec, ${drun}"
        "${mod}, T, exec, ${terminal}"
        "${mod}, L, exec, hyprlock"

        "${mod}, Q, killactive,"
        "${mod} ${alt}, Q, killactive,"
        "${mod}, SPACE, togglefloating,"
        "${mod}, F, fullscreen,"

        "${mod}, E, exit,"
        "${mod}, A, hyprexpo:expo, toggle"
        ]
        ++ (
                /* Half from the Hyprland documentation about Nix */
                builtins.concatLists (
                    builtins.genList (i:
                        let ws_id = i + 1;
                        key = toString i;
                        ws_name = toString ws_id;
                        in [
                        "${mod}, code:1${key}, workspace, ${ws_name}"
                        "${mod} ${alt}, code:1${key}, movetoworkspace, ${ws_name}"
                        "${mod} ${alt2}, code:1${key}, movetoworkspacesilent, ${ws_name}"
                        ]
                        )
                    9)
           );

        binds = {
            drag_threshold = 5;
        };

        bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
        "${mod}, Control_L, movewindow"
        ];

        bindc = [
        "${mod}, mouse:272, togglefloating"
        ];

        exec-once = [
            "${terminal} --hold zsh -c \"cbonsai -lim \"Hello!\"\""
        ];

        input = {
            kb_layout = "fr";

            touchpad = {
                natural_scroll = false;
                disable_while_typing = true;
            };
        };

        monitor = [
            "eDP-1,    preferred,  auto-right, 1"
            "HDMI-A-1, preferrred, auto-left,  1"
        ];
    };

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins;
    [
        hyprexpo
    ];
}
