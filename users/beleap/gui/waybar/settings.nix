{
  mainBar = {
    layer = "top";
    spacing = 8;
    modules-left = [
      "hyprland/workspaces"
      "mpris"
    ];
    modules-center = [ "hyprland/window" ];
    modules-right = [
      "custom/github"
      "pulseaudio"
      "bluetooth"
      "network"
      "battery"
      "backlight"
      "clock"
      "custom/uair"
      "tray"
    ];

  } // (import ./modules.nix);
}
