{ ... }:

{
  wayland.windowManager.hyprland.settings.exec = [
    "pkill -f hyprpaper;hyprpaper & disown"
  ];
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user start hyprpolkitagent"
    "waybar 2>&1 > /tmp/waybarlog.txt"
  ];
}
