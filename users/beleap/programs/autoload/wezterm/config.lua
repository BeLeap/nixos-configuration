local wezterm = require("wezterm")
return {
  font = wezterm.font {
    family = "Monaspace Neon Var",
    harfbuzz_features = { "calt", "liga", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
  },
  font_size = 14.0,
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  check_for_updates = false,
  warn_about_missing_glyphs = false,
  use_ime = true,
  default_prog = { "sh", "/home/beleap/.scripts/spawn.sh" },
}
