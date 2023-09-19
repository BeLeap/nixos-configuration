return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        term_colors = true,
        integrations = {
          aerial = true,
          indent_blankline = {
            enable = true,
            colored_indent_levels = true,
          },
          markdown = true,
          mason = true,
          neogit = true,
          cmp = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
        notify = true,
        nvimtree = true,
        treesitter_context = true,
        treesitter = true,
        ts_rainbow2 = true,
        overseer = true,
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        vimwiki = true,
        which_key = true,
      })

      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
