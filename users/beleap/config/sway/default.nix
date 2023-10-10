{ pkgs, lib }:
let
  helpers = import ../../helpers.nix {
    inherit
      pkgs
      lib;
  };
  catppuccin = {
    Rosewater = "#f5e0dc";
    Flamingo = "#f2cdcd";
    Pink = "#f5c2e7";
    Mauve = "#cba6f7";
    Red = "#f38ba8";
    Maroon = "#eba0ac";
    Peach = "#fab387";
    Yellow = "#f9e2af";
    Green = "#a6e3a1";
    Teal = "#94e2d5";
    Sky = "#89dceb";
    Sapphire = "#74c7ec";
    Blue = "#89b4fa";
    Lavender = "#b4befe";
    Text = "#cdd6f4";
    Subtext1 = "#bac2de";
    Subtext0 = "#a6adc8";
    Overlay2 = "#9399b2";
    Overlay1 = "#7f849c";
    Overlay0 = "#6c7086";
    Surface2 = "#585b70";
    Surface1 = "#45475a";
    Surface0 = "#313244";
    Base = "#1e1e2e";
    Mantle = "#181825";
    Crust = "#11111b";
  };
in
rec {
  enable = true;
  package = (helpers.nixGLIntelWrap pkgs.sway);

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
      "${config.modifier}+q" = "exec swaylock";
      "${config.modifier}+Shift+r" = "mode resize";
      "${config.modifier}+e" = "exec nautilus";
      "${config.modifier}+Ctrl+s" = "exec grim - | wl-copy";
      "${config.modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
      "${config.modifier}+v" = "exec cliphist list | wofi --dmenu -p 'Select to copy...' | cliphist decode | wl-copy";
      "${config.modifier}+n" = "exec makoctl menu wofi --dmenu -p 'Select to execute action...' || makoctl dismiss";
      "${config.modifier}+Shift+n" = "exec makoctl dismiss";
    };

    window = {
      border = 4;
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

    colors = {
      background = catppuccin.Base;
      focused = {
        border = catppuccin.Lavender;
        background = catppuccin.Base;
        text = catppuccin.Text;
        indicator = catppuccin.Rosewater;
        childBorder = catppuccin.Lavender;
      };
      focusedInactive = {
        border = catppuccin.Overlay0;
        background = catppuccin.Base;
        text = catppuccin.Text;
        indicator = catppuccin.Rosewater;
        childBorder = catppuccin.Overlay0;
      };
      unfocused = {
        border = catppuccin.Overlay0;
        background = catppuccin.Base;
        text = catppuccin.Text;
        indicator = catppuccin.Rosewater;
        childBorder = catppuccin.Overlay0;
      };
      urgent = {
        border = catppuccin.Peach;
        background = catppuccin.Base;
        text = catppuccin.Peach;
        indicator = catppuccin.Overlay0;
        childBorder = catppuccin.Peach;
      };
      placeholder = {
        border = catppuccin.Overlay0;
        background = catppuccin.Base;
        text = catppuccin.Text;
        indicator = catppuccin.Overlay0;
        childBorder = catppuccin.Overlay0;
      };
    };
  };
 
  extraConfig = ''
    input type:keyboard {
      xkb_options "ctrl:nocaps,korean:ralt_hangul"
    }

    input type:touchpad {
      tap enabled
      natural_scroll disabled
      dwt enabled
    }
  '';
}
