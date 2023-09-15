{ pkgs, lib }:
let
  swaysome = builtins.readFile(./. + "/swaysome.conf");
  helpers = import ../../helpers.nix {
    inherit
      pkgs
      lib;
  };
in
rec {
  enable = true;
  package = (helpers.nixGLMesaWrap pkgs.sway);

  systemd = {
    enable = true;
  };

  wrapperFeatures = {
    gtk = true;
  };

  config = {
    modifier = "Mod4";
    bars = [
      {
        command = "waybar";
      }
    ];
    terminal = "wezterm";
    menu = "wofi --show drun | xargs swaymsg exec -- ";
    keybindings = lib.mkOptionDefault {
      "${config.modifier}+r" = "exec ${config.menu}";
      "${config.modifier}+Shift+r" = "mode resize";
    };

    output = {
      "DP-2" = {
        scale = "1.5";
      };
    };

    startup = [
      { command = "wezterm"; }
      { command = "firefox"; }
      { command = "1password &"; }
      { command = "swaybg --color \"#1e1e2e\""; always = true; }
    ];
  };

  extraConfig = builtins.concatStringsSep "\n" [
    "set $mod ${config.modifier}"
    "bindsym $mod+q exec swaylock"
    swaysome
  ];
}
