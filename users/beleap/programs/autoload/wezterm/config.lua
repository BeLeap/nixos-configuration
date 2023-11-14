local wezterm = require("wezterm")
return {
  font = wezterm.font_with_fallback({ "Monaspace NF", "NanumGothicCoding" }),
  font_size = 14.0,
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  check_for_updates = false,
  warn_about_missing_glyphs = false,
  use_ime = true,
  default_prog = { "sh", "/home/beleap/.scripts/spawn.sh" },
}
