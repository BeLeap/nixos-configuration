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
      {
        "<M-h>",
        function()
          require('tmux').resize_left()
        end,
      },
      {
        "<M-l>",
        function()
          require('tmux').resize_right()
        end,
      },
      {
        "<M-k>",
        function()
          require('tmux').resize_up()
        end,
      },
      {
        "<M-j>",
        function()
          require('tmux').resize_down()
        end,
      },
    },
    opts = {
      enable_default_keybindings = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>st", "<Cmd>exe v:count1 . \"ToggleTerm\"<CR>" },
      {
        "<leader>sb",
        function()
          local path     = vim.fn.expand("%:p:h")
          local Terminal = require('toggleterm.terminal').Terminal
          Terminal:new({
            dir = path,
          }):toggle()
        end
      },
      { "<leader>sy", "<cmd>ToggleTermSendVisualSelection<cr>", mode = "v" },
    },
    version = "*",
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    opts = {},
  },
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
}
