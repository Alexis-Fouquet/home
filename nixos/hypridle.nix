{ ... }:
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
        timeout = 30;
        on-timeout = "notify-send \"Timeout\"";
        on-resume = "notify-send \"Resume\"";
    }
    {
        timeout = 600;
        on-timeout = "hyprlock";
        on-resume = "notify-send \"Unlocked\" \"Was locked by hypridle (timeout 600)\"";
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
