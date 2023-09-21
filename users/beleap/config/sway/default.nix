{ pkgs, lib }:
let
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
    focus = {
      newWindow = "focus";
    };
    modifier = "Mod4";
    bars = [
      {
        command = "waybar";
      }
    ];
    terminal = "wezterm";
    menu = "wofi --show drun -p 'Select application...' | xargs swaymsg exec -- ";
    keybindings = lib.mkOptionDefault {
      "${config.modifier}+r" = "exec ${config.menu}";
      "${config.modifier}+Shift+r" = "mode resize";
      # "${config.modifier}+q" = "exec swaylock";
      "${config.modifier}+e" = "exec nautilus";
      "${config.modifier}+Ctrl+s" = "exec grim - | wl-copy";
      "${config.modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
      "${config.modifier}+v" = "exec cliphist list | wofi --dmenu -p 'Select to copy...' | cliphist decode | wl-copy";
      "${config.modifier}+n" = "exec makoctl menu wofi --dmenu -p 'Select to execute action...' || makoctl dismiss";
      "${config.modifier}+Shift+n" = "exec makoctl dismiss";
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

    assigns = {
      "number 1" = [{ app_id = "org.wezfurlong.wezterm"; }];
      "number 2" = [{ app_id = "firefox"; }];
    };

    startup = [
      { command = "wezterm"; }
      { command = "firefox"; }
      { command = "firefox -P work"; }
      { command = "1password &"; }
      { command = "swaybg --color \"#1e1e2e\""; always = true; }
      { command = "systemctl --user restart kanshi.service"; always = true; }
      { command = "/home/beleap/.nix-profile/libexec/polkit-gnome-authentication-agent-1"; always = true; }
      { command = "sworkstyle"; }
      { command = "kime"; }
      { command = "wl-paste --watch cliphist store"; }
    ];
  };
 
  extraConfig = ''
    input type:keyboard {
      xkb_options ctrl:nocaps
    }

    input type:touchpad {
      tap enabled
      natural_scroll disabled
      dwt enabled
    }
  '';
}
