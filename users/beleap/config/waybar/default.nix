{
  enable = true;

  settings = {
    mainBar = {
      layer = "top";
      spacing = 8;
      modules-left = [
        "hyprland/workspaces"
        "mpris"
      ];
      modules-center = ["hyprland/window"];
      modules-right = [
        "custom/github"
        "pulseaudio"
        "bluetooth"
        "network"
        "cpu"
        "memory"
        "battery"
        "backlight"
        "clock"
        "custom/mako"
        "tray"
      ];
      
      "hyprland/workspaces" = {
        "format" = "{name}: {icon}";
        "on-click" = "activate";
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "11" = "";
          "12" = "";
          "13" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };    
      "hyprland/window" = {
        "format" = "{}";
        "rewrite" = {
          "(.*) — Mozilla Firefox" = "🌎 $1";
        };
        "separate-outputs" = true;
      };
      "custom/github" = {
        "format" = " {}";
        "return-type" = "json";
        "interval" = 60;
        "exec" = "$HOME/.config/waybar/scripts/github.sh";
        "on-click" = "xdg-open https://github.com/notifications";
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
        "exec" = "$HOME/.config/waybar/scripts/mako.sh";
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
          "paused" = "⏸";
        };
        "on-click" = "playerctl play-pause";
      };
    };
  };
  style = builtins.readFile(./. + "/style.css");
}
