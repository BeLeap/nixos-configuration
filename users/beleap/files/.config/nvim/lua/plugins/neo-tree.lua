return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>f", "<cmd>Neotree<cr>" },
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },
}
