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
  }

}
