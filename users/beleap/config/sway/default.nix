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
      "${config.modifier}+1" = "exec \"swaysome focus 1\"";
      "${config.modifier}+2" = "exec \"swaysome focus 2\"";
      "${config.modifier}+3" = "exec \"swaysome focus 3\"";
      "${config.modifier}+4" = "exec \"swaysome focus 4\"";
      "${config.modifier}+5" = "exec \"swaysome focus 5\"";
      "${config.modifier}+6" = "exec \"swaysome focus 6\"";
      "${config.modifier}+7" = "exec \"swaysome focus 7\"";
      "${config.modifier}+8" = "exec \"swaysome focus 8\"";
      "${config.modifier}+9" = "exec \"swaysome focus 9\"";

      "${config.modifier}+Shift+1" = "exec \"swaysome move 1\"";
      "${config.modifier}+Shift+2" = "exec \"swaysome move 2\"";
      "${config.modifier}+Shift+3" = "exec \"swaysome move 3\"";
      "${config.modifier}+Shift+4" = "exec \"swaysome move 4\"";
      "${config.modifier}+Shift+5" = "exec \"swaysome move 5\"";
      "${config.modifier}+Shift+6" = "exec \"swaysome move 6\"";
      "${config.modifier}+Shift+7" = "exec \"swaysome move 7\"";
      "${config.modifier}+Shift+8" = "exec \"swaysome move 8\"";
      "${config.modifier}+Shift+9" = "exec \"swaysome move 9\"";

      "${config.modifier}+o" = "exec \"swaysome next-output\"";
      "${config.modifier}+Shift+o" = "exec \"swaysome prev-output\"";

      "${config.modifier}+r" = "exec ${config.menu}";
      "${config.modifier}+Shift+r" = "mode resize";
      "${config.modifier}+q" = "exec swaylock";
      "${config.modifier}+e" = "exec nautilus";
    };

    startup = [
      { command = "wezterm"; }
      { command = "firefox"; }
      { command = "1password &"; }
      { command = "swaybg --color \"#1e1e2e\""; always = true; }
      { command = "systemctl --user restart kanshi.service"; always = true; }
      { command = "/home/beleap/.nix-profile/libexec/polkit-gnome-authentication-agent-1"; always = true; }
      { command = "swaysome init 1"; }
    ];
  };
}
