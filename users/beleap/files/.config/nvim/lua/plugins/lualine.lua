return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    keys = {
      { "<leader>1", "<cmd>LualineBuffersJump! 1<cr>", noremap = true, silent = true },
      { "<leader>2", "<cmd>LualineBuffersJump! 2<cr>", noremap = true, silent = true },
      { "<leader>3", "<cmd>LualineBuffersJump! 3<cr>", noremap = true, silent = true },
      { "<leader>4", "<cmd>LualineBuffersJump! 4<cr>", noremap = true, silent = true },
      { "<leader>5", "<cmd>LualineBuffersJump! 5<cr>", noremap = true, silent = true },
      { "<leader>6", "<cmd>LualineBuffersJump! 6<cr>", noremap = true, silent = true },
      { "<leader>7", "<cmd>LualineBuffersJump! 7<cr>", noremap = true, silent = true },
      { "<leader>8", "<cmd>LualineBuffersJump! 8<cr>", noremap = true, silent = true },
      { "<leader>9", "<cmd>LualineBuffersJump! 9<cr>", noremap = true, silent = true },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "nord",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_c = {
          {
            "diagnostics",
            source = {
              "nvim_lsp",
              "nvim_diagnostic",
            },
          },
        },
        lualine_x = { "location" },
        lualine_y = { "filetype" },
        lualine_z = { "branch" },
      },
    },
  },
}
