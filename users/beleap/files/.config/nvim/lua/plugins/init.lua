return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "stevearc/dressing.nvim",
    event = { "BufEnter" },
    config = true,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.o.termguicolors = true

      local notify = require("notify")
      notify.setup({
        render = "compact",
        top_down = true,
        max_height = 3,
      })

      vim.notify = notify
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.o.foldcolumn = "1" -- "0" is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup({
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "tpope/vim-sensible",
    event = { "BufEnter" },
  },
  {
    "wakatime/vim-wakatime",
    event = { "BufEnter" },
  },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      blacklist = {
        "/home/beleap/work/.*",
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = { "BufEnter" },
    opts = {
      mapping = { ",d" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = { "BufEnter" },
    version = "*",
    config = true,
  },
}
