let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/fd04bea4cbf76f86f244b9e2549fca066db8ddff.tar.gz";
    })
    { };
in
{
  enable = true;
  package = pkgs.k9s;

  skin = {
    k9s = {
      body = {
        fgColor = "#cdd6f4";
        bgColor = "#1e1e2e";
        logoColor = "#cba6f7";
      };
      prompt = {
        fgColor = "#cdd6f4";
        bgColor = "#181825";
        suggestColor = "#89b4fa";
      };
      info = {
        fgColor = "#fab387";
        sectionColor = "#cdd6f4";
      };
      dialog = {
        fgColor = "#f9e2af";
        bgColor = "#9399b2";
        buttonFgColor = "#1e1e2e";
        buttonBgColor = "#7f849c";
        buttonFocusFgColor = "#1e1e2e";
        buttonFocusBgColor = "#f5c2e7";
        labelFgColor = "#f5e0dc";
        fieldFgColor = "#cdd6f4";
      };
      frame = {
        border = {
          fgColor = "#cba6f7";
          focusColor = "#b4befe";
        };
        menu = {
          fgColor = "#cdd6f4";
          keyColor = "#89b4fa";
          numKeyColor = "#eba0ac";
        };
        crumbs = {
          fgColor = "#1e1e2e";
          bgColor = "#eba0ac";
          activeColor = "#f2cdcd";
        };
        status = {
          newColor = "#89b4fa";
          modifyColor = "#b4befe";
          addColor = "#a6e3a1";
          pendingColor = "#fab387";
          errorColor = "#f38ba8";
          highlightColor = "#89dceb";
          killColor = "#cba6f7";
          completedColor = "#6c7086";
        };
        title = {
          fgColor = "#94e2d5";
          bgColor = "#1e1e2e";
          highlightColor = "#f5c2e7";
          counterColor = "#f9e2af";
          filterColor = "#a6e3a1";
        };
      };
      views = {
        charts = {
          bgColor = "#1e1e2e";
          chartBgColor = "#1e1e2e";
          dialBgColor = "#1e1e2e";
          defaultDialColors = [ "#a6e3a1" "#f38ba8" ];
          defaultChartColors = [ "#a6e3a1" "#f38ba8" ];
          resourceColors = {
            cpu = [ "#cba6f7" "#89b4fa" ];
            mem = [ "#f9e2af" "#fab387" ];
          };
        };
        table = {
          fgColor = "#cdd6f4";
          bgColor = "#1e1e2e";
          cursorFgColor = "#313244";
          cursorBgColor = "#45475a";
          markColor = "#f5e0dc";
          header = {
            fgColor = "#f9e2af";
            bgColor = "#1e1e2e";
            sorterColor = "#89dceb";
          };
        };
        xray = {
          fgColor = "#cdd6f4";
          bgColor = "#1e1e2e";
          cursorColor = "#45475a";
          cursorTextColor = "#1e1e2e";
          graphicColor = "#f5c2e7";
        };
        yaml = {
          keyColor = "#89b4fa";
          colonColor = "#a6adc8";
          valueColor = "#cdd6f4";
        };
        logs = {
          fgColor = "#cdd6f4";
          bgColor = "#1e1e2e";
          indicator = {
            fgColor = "#b4befe";
            bgColor = "#1e1e2e";
          };
        };
      };
      help = {
        fgColor = "#cdd6f4";
        bgColor = "#1e1e2e";
        sectionColor = "#a6e3a1";
        keyColor = "#89b4fa";
        numKeyColor = "#eba0ac";
      };
    };
  };
}
