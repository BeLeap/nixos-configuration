{
  enable = true;
  profiles = {
    undocked = {
      outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
        }
      ];
    };
    docked = {
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
