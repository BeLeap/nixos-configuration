version = '0.21.5'
xplr.config.general.show_hidden = true

xplr.config.modes.builtin.default = {
  name = "default",
  key_bindings = {
    on_key = {
      ["e"] = {
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
      [":"] = {
        help = "action",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "action" },
        },
      },
      ["G"] = {
        help = "go to bottom",
        messages = {
          "PopMode",
          "FocusLast",
        },
      },
      ["ctrl-a"] = {
        help = "select/unselect all",
        messages = {
          "ToggleSelectAll",
        },
      },
      ["/"] = {
        help = "search",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "search" },
          { SetInputBuffer = "" },
        },
      },
      ["ctrl-i"] = {
        help = "next visited path",
        messages = {
          "NextVisitedPath",
        },
      },
      ["ctrl-o"] = {
        help = "last visited path",
        messages = {
          "LastVisitedPath",
        },
      },
      [")"] = {
        help = "next deep branch",
        messages = {
          "NextVisitedDeepBranch",
        },
      },
      ["("] = {
        help = "prev deep branch",
        messages = {
          "PreviousVisitedDeepBranch",
        },
      },
      ["ctrl-r"] = {
        help = "refresh screen",
        messages = {
          "ClearScreen",
        },
      },
      ["ctrl-u"] = {
        help = "clear selection",
        messages = {
          "ClearSelection",
        },
      },
      ["ctrl-w"] = {
        help = "switch layout",
        messages = {
          { SwitchModeBuiltin = "switch_layout" },
        },
      },
      ["d"] = {
        help = "delete",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "delete" },
        },
      },
      ["j"] = {
        help = "down",
        messages = {
          "FocusNext",
        },
      },
      ["f"] = {
        help = "filter",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "filter" },
        },
      },
      ["g"] = {
        help = "go to",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "go_to" },
        },
      },
      ["h"] = {
        help = "back",
        messages = {
          "Back",
        },
      },
      ["q"] = {
        help = "quit",
        messages = {
          "Quit",
        },
      },
      ["r"] = {
        help = "rename",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "rename" },
          {
            BashExecSilently0 = [===[
              NAME=$(basename "${XPLR_FOCUS_PATH:?}")
              "$XPLR" -m 'SetInputBuffer: %q' "${NAME:?}"
            ]===],
          },
        },
      },
      ["ctrl-d"] = {
        help = "duplicate as",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "duplicate_as" },
          {
            BashExecSilently0 = [===[
              NAME=$(basename "${XPLR_FOCUS_PATH:?}")
              "$XPLR" -m 'SetInputBuffer: %q' "${NAME:?}"
            ]===],
          },
        },
      },
      ["l"] = {
        help = "enter",
        messages = {
          "Enter",
        },
      },
      ["enter"] = {
        help = "enter",
        messages = {
          "Enter",
        },
      },
      ["s"] = {
        help = "sort",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "sort" },
        },
      },
      ["space"] = {
        help = "toggle selection",
        messages = {
          "ToggleSelection",
          "FocusNext",
        },
      },
      ["k"] = {
        help = "up",
        messages = {
          "FocusPrevious",
        },
      },
      ["~"] = {
        help = "go home",
        messages = {
          {
            BashExecSilently0 = [===[
              "$XPLR" -m 'ChangeDirectory: %q' "${HOME:?}"
            ]===],
          },
        },
      },
      ["page-up"] = {
        help = "scroll up",
        messages = {
          "ScrollUp",
        },
      },
      ["page-down"] = {
        help = "scroll down",
        messages = {
          "ScrollDown",
        },
      },
      ["{"] = {
        help = "scroll up half",
        messages = {
          "ScrollUpHalf",
        },
      },
      ["}"] = {
        help = "scroll down half",
        messages = {
          "ScrollDownHalf",
        },
      },
      ["ctrl-n"] = {
        help = "next selection",
        messages = {
          "FocusNextSelection",
        },
      },
      ["ctrl-p"] = {
        help = "prev selection",
        messages = {
          "FocusPreviousSelection",
        },
      },
      ["m"] = {
        help = "move to",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "move_to" },
          { SetInputBuffer = "" },
        },
      },
      ["c"] = {
        help = "copy to",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "copy_to" },
          { SetInputBuffer = "" },
        },
      },
    },
    on_number = {
      help = "input",
      messages = {
        "PopMode",
        { SwitchModeBuiltin = "number" },
        "BufferInputFromKey",
      },
    },
  },
}
