{ pkgs, lib, helpers, hostname }:
let
  nord = import ../../../const/nord.nix;
  assign-to-scratchpad = [
    { class = "1Password"; }
    { class = "Youtube Music"; }
    { class = "discord"; }
    { class = "Logseq"; }
    { app_id = "ColinDuquesnoy.gitlab.com."; }
  ];
in
rec {
  enable = true;
  wrapperFeatures.gtk = true;
  package = pkgs.swayfx;

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
        command = "${pkgs.waybar}/bin/waybar";
      }
    ];
    terminal = "wezterm";
    menu = "wofi --show drun -p 'Select application...' | xargs swaymsg exec -- ";
    keybindings = lib.mkOptionDefault {
      "${config.modifier}+r" = "exec ${config.menu}";
      "${config.modifier}+q" = "exec killall -s SIGUSR1 swayidle && killall -s SIGUSR1 swayidle";
      "${config.modifier}+Shift+r" = "mode resize";
      "${config.modifier}+e" = "exec nautilus";
      "${config.modifier}+Ctrl+s" = "exec grim - | wl-copy";
      "${config.modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
      "${config.modifier}+v" = "exec cliphist list | wofi --dmenu -p 'Select to copy...' | cliphist decode | wl-copy";
      "${config.modifier}+n" = "exec dunstctl action && dunstctl close";
      "${config.modifier}+Shift+n" = "exec dunstctl close";
      "${config.modifier}+t" = "layout stacking";
      "${config.modifier}+s" = null;
      "${config.modifier}+w" = null;
      "${config.modifier}+Up" = "sticky toggle";
      "${config.modifier}+p" = "exec echo \"next\\ntoggle\" | wofi --dmenu -p 'Pomodoro' | xargs uairctl";
      "${config.modifier}+m" = "exec echo \"play-pause\\nnext\\nprevious\" | wofi --dmenu -p 'Music' | xargs playerctl";
    };

    window = {
      border = 4;
      commands = [ ] ++ lib.lists.flatten (builtins.map (it: [{ command = "move scratchpad"; criteria = it; } { command = "scratchpad show"; criteria = it; }]) assign-to-scratchpad);
    };

    assigns = {
      "number 1" = [{ app_id = "org.wezfurlong.wezterm"; }];
    } // (if (helpers.isWork hostname) then {
      "number 2" = [{ app_id = "firefox-work"; }];
      "number 3" = [{ app_id = "firefox-personal"; }];
    } else {
      "number 2" = [{ app_id = "firefox-personal"; }];
      "number 3" = [{ app_id = "firefox-work"; }];
    });

    startup = [
      { command = "wezterm"; }
      { command = "firefox -P personal --name firefox-personal"; }
      { command = "firefox -P work --name firefox-work"; }
      { command = "1password &"; }
      { command = "discord &"; }
      { command = "logseq &"; }
      { command = "swaybg --color \"${nord.nord0}\""; always = true; }
      { command = "systemctl --user restart kanshi.service"; always = true; }
      { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; always = true; }
      { command = "kime"; }
      { command = "wl-paste --watch cliphist store"; }
      { command = "bash /home/beleap/.scripts/idle.sh"; }
    ];

    colors = {
      background = nord.nord0;
      focused = {
        border = nord.nord8;
        background = nord.nord1;
        text = nord.nord4;
        indicator = nord.nord8;
        childBorder = nord.nord8;
      };
      focusedInactive = {
        border = nord.nord1;
        background = nord.nord1;
        text = nord.nord4;
        indicator = nord.nord1;
        childBorder = nord.nord1;
      };
      unfocused = {
        border = nord.nord1;
        background = nord.nord1;
        text = nord.nord4;
        indicator = nord.nord1;
        childBorder = nord.nord1;
      };
      urgent = {
        border = nord.nord11;
        background = nord.nord1;
        text = nord.nord11;
        indicator = nord.nord11;
        childBorder = nord.nord11;
      };
      placeholder = {
        border = nord.nord1;
        background = nord.nord1;
        text = nord.nord4;
        indicator = nord.nord1;
        childBorder = nord.nord1;
      };
    };

    gaps = {
      inner = 6;
      smartGaps = false;
    };
  };

  extraConfig = ''
    input type:keyboard {
      xkb_layout us
      xkb_variant colemak
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
