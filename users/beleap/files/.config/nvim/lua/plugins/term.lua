return {
  {
    "aserowy/tmux.nvim",
    keys = {
      {
        "<C-h>",
        function()
          require('tmux').move_left()
        end,
      },
      {
        "<C-l>",
        function()
          require('tmux').move_right()
        end,
      },
      {
        "<C-k>",
        function()
          require('tmux').move_up()
        end,
      },
      {
        "<C-j>",
        function()
          require('tmux').move_down()
        end,
      },
    },
    opts = {
      enable_default_keybindings = false,
    },
  },
}
