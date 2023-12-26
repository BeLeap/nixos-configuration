{
  enable = true;

  settings = {
    mainBar = {
      layer = "top";
      spacing = 8;
      modules-left = [
        "sway/mode"
        "sway/workspaces"
        "mpris"
      ];
      modules-center = ["sway/window"];
      modules-right = [
        "custom/github"
        "pulseaudio"
        "bluetooth"
        "network"
        "battery"
        "backlight"
        "clock"
        "custom/uair"
        "custom/mako"
        "tray"
      ];

      "sway/mode" = {
        "format" = "{}";
      };
      "sway/workspaces" = {
        "format" = "{name}: {icon}";
        "on-click" = "activate";
        "format-icons" = {
          "urgent" = "";
          "focused" = "";
          "default" = "";
        };
      };
      "sway/window" = {
        "format" = "{app_id} / {title}";
        "separate-outputs" = true;
        "rewrite" = {
          "(.*) \\[Sidebery\\] (.*)" = "$1 $2";
          "org.wezfurlong.wezterm (.*)" = "wezterm $1";
        };
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}% {format_source}";
        "format-bluetooth" = "{icon} {volume}% {format_source}";
        "format-bluetooth-muted" = "Muted {icon} {format_source}";
        "format-muted" = "Muted {format_source}";
        "format-source" = " {volume}%";
        "format-source-muted" = "";
        "format-icons" = {
          "headphone" = "Headphone";
          "hands-free" = "HandsFree";
          "headset" = "Headset";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = ["" "" ""];
        };
        "on-click" = "pavucontrol";
      };
      "network" = {
        "format-wifi" = "  {essid} ({signalStrength}%)";
        "format-ethernet" = "󰈀 {ipaddr}/{cidr}";
        "tooltip-format" = "{ifname} via {gwaddr}";
        "format-linked" = "{ifname} (No IP)";
        "format-disconnected" = "⚠ Disconnected";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      "cpu" = {
        "format" = " {usage}%";
        "tooltip" = false;
      };
      "memory" = {
        "format" = "󰍛 {}%";
      };
      "temperature" = {
        "critical-threshold" = 80;
        "format" = " {temperatureC}°C";
      };
      "backlight" = {
        "device" = "intel_backlight";
        "format" = "{icon} {percent}%";
        "format-icons" = ["" ""];
      };
      "battery" = {
        "states" = {
          "good" = 95;
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon} {capacity}%";
        "format-charging" = "Charging {capacity}%";
        "format-plugged" = "Plugged {capacity}%";
        "format-alt" = "{icon} {time}";
        "format-icons" = [" " " " " " " " " "];
      };
      "clock" = {
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };
      "tray" = {
        "spacing" = 4;
      };
      "bluetooth" = {
        "format" = " {status}";
        "format-disabled" = "";
        "format-connected" = " {num_connections} connected";
        "tooltip-format" = "{controller_alias}\t{controller_address}";
        "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        "on-click" = "blueman-manager";
      };
      "custom/mako" = {
        "exec-if" = "command -v makoctl";
        "exec" = "sh /home/beleap/.scripts/mako.sh";
        "format" = "{}";
        "on-click" = "makoctl dismiss -a";
        "interval" = 3;
      };
      "mpris" = {
        "format" = "{player_icon} {dynamic}";
        "format-paused" = "{status_icon} <i>{dynamic}</i>";
        "player-icons" = {
          "default" = "▶";
          "mpv" = "🎵";
        };
        "status-icons" = {
          "paused" = " ";
        };
        "on-click" = "playerctl play-pause";
      };
      "custom/uair" = {
        "exec-if" = "command -v uair";
        "exec" = "uair";
        "format" = "{}";
        "on-click" = "uairctl toggle";
        "on-click-right" = "uairctl next";
      };
    };
  };
  style = builtins.readFile(./. + "/style.css");
}
