{ pkgs, ... }:
let mod = "SUPER";
alt = "SHIFT";
alt2 = "CTRL";
browser = "flatpak run app.zen_browser.zen";
terminal = "kitty";
drun = "wofi --show drun";
toggleNotifications = "swaync-client -t -sw";
in {
    home.packages = with pkgs;
    [
    wofi
    nautilus
    hyprpicker
    overskride
    hyprshot
    obsidian
    ];

    services.hyprpaper.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
    };

    wayland.windowManager.hyprland.settings = {
        binds = {
            drag_threshold = 5;
            /* Allows to go to recently used workspaces. */
            allow_workspace_cycles = true;
        };

        bind = [
        "${mod}, B, exec, ${browser}"
        "${mod}, D, exec, ${drun}"
        "${mod}, T, exec, ${terminal}"
        "${mod}, L, exec, hyprlock"

        /* Windows */
        "${mod}, Q, killactive,"
        "${mod} ${alt}, Q, killactive,"
        "${mod}, SPACE, togglefloating,"
        "${mod}, F, fullscreen,"

        /* Workspaces */
        "${mod}, Z, workspace, previous_per_monitor"
        "${mod}, TAB, workspace, m+1"
        "${mod} ${alt}, TAB, workspace, m-1"
        "${mod} ${alt2}, TAB, workspace, emptynm"

        "${mod}, E, exit,"
        "${mod}, A, hyprexpo:expo, toggle"

        "${mod}, N, exec, ${toggleNotifications}"

        "${mod}, S, exec, hyprshot -m region"
        ]
        ++ (
                /* Half from the Hyprland documentation about Nix */
                builtins.concatLists (
                    builtins.genList (i:
                        let ws_id = i + 1;
                        key = "code:1${toString i}";
                        ws_name = toString ws_id;
                        in [
                        "${mod}, ${key}, workspace, ${ws_name}"
                        "${mod} ${alt}, ${key}, movetoworkspace, ${ws_name}"
                        "${mod} ${alt2}, ${key}, movetoworkspacesilent, ${ws_name}"
                        ]
                        )
                    9)
           );

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
            numlock_by_default = true;

            repeat_rate = 38;
            repeat_delay = 300;

            touchpad = {
                natural_scroll = false;
                disable_while_typing = true;
            };
        };

        monitor = [
            "eDP-1,    preferred,  auto-right, 1"
            "HDMI-A-1, preferrred, auto-left,  1"
        ];

        animations = {
            enabled = true;
        };

        animation = [
        "workspaces, 1, 2, default, slidefade"
        "windows, 1, 4, default, slide"
        ];
    };

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins;
    [
        hyprexpo
    ];
}
