{ pkgs, isWork }:
let
  nord = import ../../../const/nord.nix;
in
{
  enable = true;

  settings = {
    "$mod" = "SUPER";

    bind = [
      "$mod, x, exec, ${pkgs.foot}/bin/foot"
      "$mod, R, exec, wofi --show drun -p 'Select application...'"
      "$mod SHIFT, Q, killactive"

      # Move focus between windows
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # Move windows
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      # Scratchpad
      "$mod CTRL, H, exec, pypr toggle right"
      "$mod CTRL, L, exec, pypr toggle left"

      # Minimized
      "$mod, U, togglespecialworkspace, minimized"
      "$mod SHIFT, M, exec, pypr toggle_minimized"

      # Notifications
      "$mod, N, exec, dunstctl action && dunstctl close"
      "$mod SHIFT, N, exec, dunstctl close"

      # Screenshots
      "$mod SHIFT, S, exec, hyprshot -m region"
      "$mod CTRL, S, exec, hyprshot -m window"
      "$mod SHIFT_CTRL, S, exec, hyprshot -m output"

      # Others
      "$mod, P, exec, echo -e \"next\\ntoggle\" | wofi --dmenu -p 'Pomodoro' | xargs uairctl"
      "$mod, M, exec, echo -e \"play-pause\\nnext\\nprevious\" | wofi --dmenu -p 'Music' | xargs playerctl"
      "$mod, Q, exec, killall -s SIGUSR1 swayidle && killall -s SIGUSR1 swayidle"
      "$mod SHIFT, R, resizeactive, 50% 50%"
      "$mod SHIFT_CTRL, Q, exit"
    ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );

    exec-once = [
      "${pkgs.swaybg}/bin/swaybg -c '#${nord.nord0}'"
      "${pkgs.waybar}/bin/waybar"
      "bash /home/beleap/.scripts/idle.sh"
      "pypr"
      # Tools
      "${pkgs.foot}/bin/foot"
      "firefox -P personal --name firefox-personal"
      "firefox -P work --name firefox-work"
      "discord"
    ];

    exec = [
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      "systemctl --user restart kanshi.service"
    ];

    input = {
      kb_variant = "colemak";
      kb_options = "ctrl:nocaps";
    };

    decoration = {
      rounding = 10;
    };

    master = {
      new_is_master = false;
    };

    misc = {
      focus_on_activate = true;
      disable_hyprland_logo = true;
      force_hypr_chan = false;
    };

    general = {
      layout = "master";
      border_size = 4;
      "col.inactive_border" = "rgb(${nord.hexify nord.nord1})";
      "col.active_border" = "rgb(${nord.hexify nord.nord8})";
    };

    xwayland = {
      force_zero_scaling = true;
    };

    env = [
      "GDK_SCALE,1.5"
      "XCURSOR_SIZE,32"
    ];

    windowrulev2 = [
      "float,class:(1Password)"
      "workspace special:minimized,class:(discord)"

      "workspace 1,class:(foot)"
    ] ++ (
      if isWork then
        [
          "workspace 2,class:(firefox-work)"
          "workspace 3,class:(firefox-personal)"
        ]
      else
        [
          "workspace 2,class:(firefox-personal)"
          "workspace 3,class:(firefox-work)"
        ]
    );
  };

  extraConfig = ''
  '';
}
