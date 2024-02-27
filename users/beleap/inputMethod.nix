{
  enabled = "kime";

  kime.config = {
    indicator.icon_color = "White";
    engine = {
      latin = {
        layout = "Colemak";
      };
      hangul = {
        layout = "sebeolsik-3-90";
        addons = {
          "sebeolsik-3-90" = [
            "FlexibleComposeOrder"
            "ComposeChoseongSsang"
            "ComposeJongseongSsang"
          ];
        };
      };
    };
  };
}
