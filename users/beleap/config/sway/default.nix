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
      "${config.modifier}+q" = "exec swaylock";
      "${config.modifier}+e" = "exec nautilus";
    };

    window = {
      commands = [
        {
          command = "resize set 900 500";
          criteria = { class = "1Password"; };
        }
      ];
    };

    floating = {
      criteria = [
        { class = "1Password"; }
      ];
    };

    startup = [
      { command = "wezterm"; }
      { command = "firefox"; }
      { command = "1password &"; }
      { command = "swaybg --color \"#1e1e2e\""; always = true; }
      { command = "systemctl --user restart kanshi.service"; always = true; }
      { command = "/home/beleap/.nix-profile/libexec/polkit-gnome-authentication-agent-1"; always = true; }
      { command = "sworkstyle"; }
    ];
  };
 
  extraConfig = ''
    input type:keyboard {
      # Capslock key should work as escape key
      # See /usr/share/X11/xkb/rules/xorg.lst for options
      xkb_options ctrl:nocaps
    }
  '';
}
