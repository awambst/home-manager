{ ... }:
{
  programs.polybar = {
    enable = true;
    script = "polybar main &";

    config = {
      "bar/main" = {
        modules-right = "powermenu-menu cpu memory";
        # ... other bar config
      };

      "module/powermenu" = {
        type = "custom/text";
        content = "⏻"; # Power symbol
        content-foreground = "#f44336";
        click-left = "systemctl poweroff";
        click-right = "systemctl reboot";
      };

      # Or a menu-style powermenu
      "module/powermenu-menu" = {
        type = "custom/menu";

        label-open = "⏻";
        label-close = "✕";

        menu-0-0 = "⏻ Shutdown";
        menu-0-0-exec = "systemctl poweroff";
        menu-0-1 = "↻ Reboot";
        menu-0-1-exec = "systemctl reboot";
        menu-0-2 = "⏾ Suspend";
        menu-0-2-exec = "systemctl suspend";
      };
    };
  };
}
