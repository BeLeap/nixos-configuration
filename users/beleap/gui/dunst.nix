{ pkgs }:
let
  nord = import ../../../const/nord.nix;
in
{
  enable = true;

  settings = {
    global = {
      background = nord.nord0;
      foreground = nord.nord4;
      frame_color = nord.nord8;
      offset = "0x0";
      corner_radius = 10;
      frame_width = 4;
      separator_height = 4;
      dmenu = "wofi --show dmenu -p dunst";
      font = "Monospace 12";
    };
    urgency_low = {
      timeout = 5;
    };
    urgency_normal = {
      timeout = 10;
    };
    urgency_critical = {
      frame_color = nord.nord11;
      timeout = 0;
    };
    play_sound = {
      summary = "*";
      script = "~/.scripts/alert.sh";
    };
  };
}
