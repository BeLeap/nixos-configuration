return {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup()
      vim.cmd [[set background=dark]]
      vim.cmd [[colorscheme nord]]
    end,
  },
}
