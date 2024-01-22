let
  nord = import ../../../const/nord.nix;
in
{
  enable = true;

  skins = {
    nord = {
      k9s = {
        body = {
          fgColor = nord.nord4;
          bgColor = nord.nord0;
          logoColor = nord.nord10;
        };
        prompt = {
          fgColor = nord.nord4;
          bgColor = nord.nord0;
          suggestColor = nord.nord12;
        };
        info = {
          fgColor = nord.nord8;
          sectionColor = nord.nord4;
        };
        dialog = {
          fgColor = nord.nord4;
          bgColor = nord.nord0;
          buttonFgColor = nord.nord4;
          buttonBgColor = nord.nord1;
          buttonFocusFgColor = nord.nord4;
          buttonFocusBgColor = nord.nord1;
          labelFgColor = nord.nord8;
          fieldFgColor = nord.nord11;
        };
        frame = {
          border = {
            fgColor = nord.nord10;
            focusColor = nord.nord10;
          };
          menu = {
            fgColor = nord.nord4;
            keyColor = nord.nord14;
            numKeyColor = nord.nord14;
          };
          crumbs = {
            fgColor = nord.nord4;
            bgColor = nord.nord0;
            activeColor = nord.nord14;
          };
          status = {
            newColor = nord.nord8;
            modifyColor = nord.nord13;
            addColor = nord.nord14;
            pendingColor = nord.nord13;
            errorColor = nord.nord11;
            highlightColor = nord.nord8;
            killColor = nord.nord14;
            completedColor = nord.nord10;
          };
          title = {
            fgColor = nord.nord4;
            bgColor = nord.nord0;
            highlightColor = nord.nord8;
            counterColor = nord.nord8;
            filterColor = nord.nord13;
          };
        };
        views = {
          charts = {
            bgColor = nord.nord0;
            chartBgColor = nord.nord0;
            dialBgColor = nord.nord0;
            defaultDialColors = [ nord.nord8 nord.nord11 ];
            defaultChartColors = [ nord.nord8 nord.nord11 ];
          };
          table = {
            fgColor = nord.nord4;
            bgColor = nord.nord0;
            cursorFgColor = nord.nord0;
            cursorBgColor = nord.nord0;
            markColor = nord.nord4;
            header = {
              fgColor = nord.nord4;
              bgColor = nord.nord0;
              sorterColor = nord.nord8;
            };
          };
          xray = {
            fgColor = nord.nord4;
            bgColor = nord.nord0;
            cursorColor = nord.nord8;
            cursorTextColor = nord.nord4;
            graphicColor = nord.nord8;
          };
          yaml = {
            keyColor = nord.nord8;
            colonColor = nord.nord8;
            valueColor = nord.nord4;
          };
          logs = {
            fgColor = nord.nord4;
            bgColor = nord.nord0;
            indicator = {
              fgColor = nord.nord4;
              bgColor = nord.nord10;
            };
          };
        };
        help = {
          fgColor = nord.nord4;
          bgColor = nord.nord0;
        };
      };
    };
  };
}
