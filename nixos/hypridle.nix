{ ... }:
/* libnotify added to path of user service in configuration.nix */
let notify = name: description: "notify-send \"${name}\" \"${description}\"";
in
{
    services.hypridle = {
        enable = true;
    };

    services.hypridle.settings.general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
    };

    services.hypridle.settings.listener = [
    {
        timeout = 300;
        on-timeout = notify "Idle" "Idle detected, timeout 300";
        on-resume = notify "Idle" "Idle resumed";
    }
    {
        timeout = 600;
        on-timeout = "hyprlock";
        on-resume = notify "Unlocked" "Was locked by hypridle (timeout 600)";
    }
    {
        timeout = 660;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
    }
    {
        timeout = 1000;
        on-timeout = "systemctl suspend";
    }
    ];
}
