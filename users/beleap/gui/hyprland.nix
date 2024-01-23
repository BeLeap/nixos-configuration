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

      # Notifications
      "$mod, N, exec, dunstctl action && dunstctl close"
      "$mod SHIFT, N, exec, dunstctl close"

      # Screenshots
      "$mod SHIFT, S, exec, hyprshot -m region"
      "$mod CTRL, S, exec, hyprshot -m window"

      # Others
      "$mod, P, exec, echo \"next\\ntoggle\" | wofi --dmenu -p 'Pomodoro' | xargs uairctl"
      "$mod, M, exec, echo \"play-pause\\nnext\\nprevious\" | wofi --dmenu -p 'Music' | xargs playerctl"
      "$mod, Q, exec, killall -s SIGUSR1 swayidle && killall -s SIGUSR1 swayidle"
      "$mod SHIFT, R, resizeactive, 50% 50%"
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
      # Tools
      "${pkgs.foot}/bin/foot"
      "firefox -P personal --name firefox-personal"
      "firefox -P work --name firefox-work"
      "1password"
      "discord"
    ];

    exec = [
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
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

    windowrule = [
      "float,1Password"
      "float,discord"

      "workspace 1,foot"
    ] ++ (
      if isWork then
        [
          "workspace 2,firefox-work"
          "workspace 3,firefox-personal"
        ]
      else
        [
          "workspace 2,firefox-personal"
          "workspace 3,firefox-work"
        ]
    );
  };

  extraConfig = ''
  '';
}
