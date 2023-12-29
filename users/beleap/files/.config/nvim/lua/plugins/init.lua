return {
  -- UI
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>p",
        function()
          require("telescope").extensions.projects.projects()
        end,
        silent = true,
      },
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        pattern = { "root.md", ">projects" },
        silent_chdir = true,
        show_hidden = true,
        excluder_dirs = {
          "*/node_modules/*",
          "/tmp/*",
        },
      })
      require("telescope").load_extension("projects")
    end,
  },
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
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>d", ":DBUIToggle<cr>", silent = true },
    },
    dependencies = {
      "tpope/vim-dadbod",
    },
    config = function()
      vim.g.db_ui_auto_execute_table_helpers = true
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufEnter" },
    config = true,
  },
  {
    "stevearc/dressing.nvim",
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
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>f", "<cmd>NvimTreeToggle<cr>" },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filters = {
          git_ignored = false,
        },
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
        pattern = "NvimTree_*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
            vim.cmd("confirm quit")
          end
        end
      })
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
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- Language
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
    "fatih/vim-go",
    event = {
      "BufEnter *.go",
      "BufEnter go.mod",
      "BufEnter go.sum",
    },
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

  -- Others
  {
    "tpope/vim-sensible",
    event = { "BufEnter" },
  },
  {
    "wakatime/vim-wakatime",
    event = { "BufEnter" },
  },
  {
    "nacro90/numb.nvim",
    event = { "BufEnter" },
    config = true,
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
  {
    "https://git.sr.ht/~soywod/himalaya-vim",
    cmd = { "Himalaya" },
    init = function()
      vim.g.himalaya_folder_picker = "telescope"
      vim.g.himalaya_folder_picker_telescope_preview = 1
    end,
  },
}
