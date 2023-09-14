{
  systemd = {
    enable = true;
  };

  wrapperFeatures = {
    gtk = true;
  };

  config = {
    bars = [
      {
        command = "waybar";
      }
    ];
    terminal = "wezterm";
    menu = "tofi-drun --drun-launch=true";
  };
}
