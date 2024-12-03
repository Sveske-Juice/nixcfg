{lib, config, pkgs, ... }:

{
  /* home.packages = with pkgs; [
    hyprpolkitagent
    hyprpaper
  ]; */
  imports = [
    ./exec.nix
  ];

  /* xdg.portal = {
    config = {
        common = {
            default = [
                "hyprland"
                "gtk"
            ];
        };
    };
    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  }; */

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      autogenerated = false;
      misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
      };
      monitor = [
        ",preffered,auto,1"
      ];
      input = {
        kb_layout = "dk";
        follow_mouse = true;
        touchpad.natural_scroll = true;
      };
      "$mod" = "super";
      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, D, exec, tofi-drun | /bin/sh"
        "$mod SHIFT, S, exec, grimblast --freeze copy area"
        "$mod SHIFT, E, exec, hyprctl dispatch exit"
      ] ++ (
        # Auto generate workspace switching from [0-9] and shift + [0-9]
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}