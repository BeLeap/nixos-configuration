return {
  {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        strategy = {
          "toggleterm",
          direction = "vertical",
          close_on_exit = false,
          use_shell = true,
          on_create = function(t)
            local function override_exit(self, cmd)
              local Terminal = require('toggleterm.terminal').Terminal
              if (cmd == "exit $?") then
                Terminal.send(self, "exit $status")
              else
                Terminal.send(self, cmd)
              end
            end
            t.send = override_exit
          end
        },
      })
      overseer.register_template({
        name = "Terraform Plan",
        builder = function()
          local parent = vim.fn.expand("%:p:h")
          return {
            cmd = { "terraform" },
            args = { "plan" },
            cwd = parent,
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "terraform" },
        },
      })
      overseer.register_template({
        name = "Terraform Apply",
        builder = function()
          local parent = vim.fn.expand("%:p:h")
          return {
            cmd = { "terraform" },
            args = { "apply", "-auto-approve" },
            cwd = parent,
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "terraform" },
        },
      })
    end
  },
}
