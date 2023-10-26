{ pkgs, lib }:
let
  helpers = import ../../helpers.nix {
    inherit
      pkgs
      lib;
  };
  catppuccin = import ../../../../const/catppuccin.nix;
  assign-to-scratchpad = [
    { class = "Youtube Music"; }
    { class = "Discord"; }
    { class = "Logseq"; }
  ];
in
rec {
  enable = true;
  package = (helpers.nixGLIntelWrap pkgs.swayfx);

  systemd = {
    enable = true;
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
      "${config.modifier}+t" = "layout stacking";
      "${config.modifier}+s" = null;
      "${config.modifier}+w" = null;
    };

    window = {
      border = 4;
      commands = [
        {
          command = "resize set 900 500";
          criteria = { class = "1Password"; };
        }
      ] ++ lib.lists.flatten (builtins.map (it: [ { command = "move scratchpad"; criteria = it; } { command = "scratchpad show"; criteria = it; } ] ) assign-to-scratchpad);
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
      background = catppuccin.base;
      focused = {
        border = catppuccin.lavender;
        background = catppuccin.base;
        text = catppuccin.text;
        indicator = catppuccin.lavender;
        childBorder = catppuccin.lavender;
      };
      focusedInactive = {
        border = catppuccin.overlay0;
        background = catppuccin.base;
        text = catppuccin.text;
        indicator = catppuccin.overlay0;
        childBorder = catppuccin.overlay0;
      };
      unfocused = {
        border = catppuccin.overlay0;
        background = catppuccin.base;
        text = catppuccin.text;
        indicator = catppuccin.overlay0;
        childBorder = catppuccin.overlay0;
      };
      urgent = {
        border = catppuccin.peach;
        background = catppuccin.base;
        text = catppuccin.peach;
        indicator = catppuccin.peach;
        childBorder = catppuccin.peach;
      };
      placeholder = {
        border = catppuccin.overlay0;
        background = catppuccin.base;
        text = catppuccin.text;
        indicator = catppuccin.overlay0;
        childBorder = catppuccin.overlay0;
      };
    };

    gaps = {
      inner = 6;
      smartGaps = false;
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

    corner_radius 10
    smart_corner_radius on
  '';
}
