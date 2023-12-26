{ pkgs }:
let
  catppuccin = import ../../../../../const/catppuccin.nix;
in
{
  enable = true;

  settings = {
    global = {
      background = catppuccin.base;
      foreground = catppuccin.text;
      frame_color = catppuccin.lavender;
      offset = "0x0";
      corner_radius = 10;
      frame_width = 4;
      dmenu = "wofi --show dmenu -p dunst";
    };
    urgency_low = {
        timeout = 5;
    };
    urgency_normal = {
      timeout = 10;
    };
    urgency_critical = {
      frame_color = catppuccin.peach;
      timeout = 0;
    };
    play_sound = {
      summary = "*";
      script = "~/.scripts/alert.sh";
    };
  };
}
