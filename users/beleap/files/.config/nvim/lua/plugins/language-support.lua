return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      filetypes = {
        ["*"] = true,
      },
    },
  },
  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = "VeryLazy",
    opts = {
      attach_mounts = {
        neovim_config = {
          enabled = true,
          options = { "readonly" }
        },
        neovim_data = {
          enabled = false,
          options = {}
        },
        -- Only useful if using neovim 0.8.0+
        neovim_state = {
          enabled = false,
          options = {}
        },
      },
    },
  },
  {
    "elkowar/yuck.vim",
    event = "VeryLazy",
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufEnter" },
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufEnter" },
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  { "lbrayner/vim-rzip" },
  { "dmix/elvish.vim" },
  {
    "hashivim/vim-terraform",
    event = { "BufEnter *.tf" },
  },
  {
    "simrat39/rust-tools.nvim",
    event = { "BufEnter *.rs", "BufEnter *.toml" },
  },
  {
    "mhinz/vim-crates",
    event = { "BufEnter Cargo.toml" },
  },
  {
    "mfussenegger/nvim-jdtls",
    event = { "BufEnter *.java", "BufEnter *.kt" },
  },
  {
    "udalov/kotlin-vim",
    event = { "BufEnter *.kt" },
  },
  {
    "ziglang/zig.vim",
    event = { "BufEnter *.zig" },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufEnter" },
    config = true,
  },
}
