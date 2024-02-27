version = '0.21.5'
xplr.config.general.show_hidden = true

xplr.config.modes.builtin.default = {
  key_bindings = {
    on_key = {
      e = {
        help = "Edit",
        messages = {
          {
            BashExec0 = [===[
              ${EDITOR:-vi} "${XPLR_FOCUS_PATH:?}"
            ]===],
          },
          "PopMode",
        },
      },
    },
  },
}
