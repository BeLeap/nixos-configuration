return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>sb",
        function()
          local buffer_dir = vim.fn.expand("%:p:h")
          require("toggleterm").toggle_command("dir=" .. buffer_dir, 1)
        end,
        noremap = true,
        silent = true,
      },
      {
        "<leader>ss",
        ":'<,'>ToggleTermSendVisualSelection<cr>",
        mode = "x",
        noremap = true,
      },
      {
        "<leader>st",
        "<cmd>exe v:count1 . 'ToggleTerm'<cr>",
        noremap = true,
        silent = true,
      },
      {
        "<leader>sp",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local pr = Terminal:new({
            count = 5,
            cmd = "gh pr create --assignee @me",
            direction = "float",
            float_opts = {
              border = "curved",
              width = 100,
            },
            on_open = function(term)
              vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "n",
                "q",
                "<cmd>close<CR>",
                { noremap = true, silent = true }
              )
            end,
          })
          pr:toggle()
        end,
      },
    },
    cmd = { "ToggleTerm", "ToggleTermSendVisualSeleection" },
    config = function()
      if vim.loop.os_uname().sysname == "Windows_NT" then
        local powershell_options = {
          shell = vim.fn.executable("pwsh") and "pwsh" or "powershell",
          shellcmdflag =
          "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
          shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
          shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
          shellquote = "",
          shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
          vim.opt[option] = value
        end
      end
      vim.env.INTEGRATED_TERMINAL = true

      require("toggleterm").setup({
        autochdir = false,
        persist_size = false,
      })

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        pattern = { "term://*" },
        callback = function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", ",d", [[<c-\><c-n>]], opts)
          vim.keymap.set("t", ",c", [[<c-\><c-n>:ToggleTerm<cr>]], opts)
        end,
      })
    end,
  },
  {
    'willothy/flatten.nvim',
    dependencies = { 'willothy/wezterm.nvim' },
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = "tab",
        },
        callbacks = {
          should_block = function(argv)
            vim.print(argv)
            return vim.tbl_contains(argv, "-b")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              saved_terminal:close()
            else
              require("wezterm").switch_pane.id(
                tonumber(os.getenv("WEZTERM_PANE"))
              )
            end
            vim.api.nvim_set_current_win(winnr)

            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
    lazy = false,
    priority = 1001,
  },
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
    },
    config = true,
  },
}
