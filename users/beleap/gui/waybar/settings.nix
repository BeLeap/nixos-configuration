{
  mainBar = {
    layer = "top";
    spacing = 8;
    modules-left = [
      "sway/mode"
      "sway/workspaces"
      "mpris"
    ];
    modules-center = [ "sway/window" ];
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
