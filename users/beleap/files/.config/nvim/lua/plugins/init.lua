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
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
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
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeToggle<cr>")

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
        group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
        pattern = "NvimTree_*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
        end
      })
		end,
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
		"mg979/vim-visual-multi",
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
				"~/work/*",
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
		"axkirillov/hbac.nvim",
		event = "VeryLazy",
		config = function()
			require("hbac").setup()
		end,
	},
	{
		"https://git.sr.ht/~soywod/himalaya-vim",
		cmd = { "Himalaya" },
		init = function()
			vim.g.himalaya_folder_picker = "telescope"
			vim.g.himalaya_folder_picker_telescope_preview = 1
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
			local wk = require("which-key")
			wk.setup({})

			wk.register({
				g = {
					name = "+Git",
					h = {
						name = "+Github",
						p = {
							name = "+Pull Request",
							l = { "<cmd>Octo pr list<cr>", "List" },
							m = { "<cmd>Octo pr merge<cr>", "Merge" },
							sd = { "<cmd>Octo pr merge squash delete<cr>", "Squash and Delete" },
							c = { "<cmd>Octo pr create<cr>", "Create" },
							d = { "<cmd>Octo pr close<cr>", "Close" },
						},
						c = {
							name = "+Comment",
							a = { "<cmd>Octo comment add<cr>", "Add" },
							d = { "<cmd>Octo comment delete<cr>", "Delete" },
						},
					},
					n = { "<cmd>Neogit<cr>", "Neogit" },
				},
				t = {
					name = "+Telescope",
					x = {
						function()
							require("telescope.builtin").builtin()
						end,
						"Builtin",
					},
					f = {
						function()
							require("telescope.builtin").find_files()
						end,
						"Find Files",
					},
					g = {
						function()
							require("telescope.builtin").live_grep()
						end,
						"Live Grep",
					},
					b = {
						function()
							require("telescope.builtin").buffers()
						end,
						"Buffers",
					},
					h = {
						function()
							require("telescope.builtin").help_tags()
						end,
						"Helps",
					},
					c = {
						function()
							require("telescope.builtin").git_branches()
						end,
						"Git Branches",
					},
					l = {
						name = "+LSP",
						s = {
							function()
								require("telescope.builtin").lsp_document_symbols()
							end,
							"Symbols",
						},
					},
					t = {
						"<cmd>Telescope tasks specs<cr>",
						"Spawn Tasks",
					},
				},
			}, { prefix = "<leader>" })
		end,
	},
}
