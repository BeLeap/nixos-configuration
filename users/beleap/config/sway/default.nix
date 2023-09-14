let
  swaysome = builtins.readFile(./. + "/swaysome.conf");
in
{
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
    menu = "tofi-drun --drun-launch=true";

    output = {
      "DP-2" = {
        scale = "1.5";
      };
    };
  };

  extraConfig = swaysome;
}
