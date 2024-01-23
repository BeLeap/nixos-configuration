{
  enable = true;
  systemdTarget = "hyprland-session.target";

  profiles = {
    undocked = {
      outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
          scale = 1.0;
        }
      ];
    };
    home = {
      outputs = [
        {
          criteria = "eDP-1";
          status = "disable";
        }
        {
          criteria = "WAM V28UE demoset-1";
          status = "enable";
          scale = 1.5;
        }
      ];
    };
    work = {
      outputs = [
        {
          criteria = "eDP-1";
          status = "disable";
        }
        {
          criteria = "LG Electronics LG ULTRAFINE 111NTNHBH783";
          status = "enable";
          scale = 1.5;
        }
      ];
    };
  };
}
