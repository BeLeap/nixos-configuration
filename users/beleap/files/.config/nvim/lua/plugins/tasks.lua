return {
  {
    "GustavoKatel/tasks.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("tasks")

      local tasks = require("tasks")

      local source_npm = require("tasks.sources.npm")
      local source_tasksjson = require("tasks.sources.tasksjson")

      local builtin = require("tasks.sources.builtin")

      tasks.setup({
        sources = {
          npm = source_npm,
          vscode = source_tasksjson,
          terraform = builtin.new_builtin_source({
            plan = {
              fn = function()
                local Terminal = require("toggleterm.terminal").Terminal
                local file_dir = vim.fs.dirname(vim.fn.expand("%:p"))
                local term = Terminal:new({
                  cmd = "cd " .. file_dir .. "; direnv exec " .. file_dir .. " terraform plan",
                  cwd = file_dir,
                  close_on_exit = false,
                })
                term:toggle()
              end,
            },
            apply = {
              fn = function()
                local Terminal = require("toggleterm.terminal").Terminal
                local file_dir = vim.fs.dirname(vim.fn.expand("%:p"))
                local term = Terminal:new({
                  cmd = "cd " .. file_dir .. "; direnv exec " .. file_dir .. " terraform apply",
                  cwd = file_dir,
                  close_on_exit = false,
                })
                term:toggle()
              end,
            },
          }),
        },
      })
    end,
  },
}
