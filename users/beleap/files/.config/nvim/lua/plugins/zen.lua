return {
	{
		"folke/twilight.nvim",
		cmd = {
			"Twilight",
			"TwilightEnable",
			"TwilightDisable",
		},
		config = function()
			require("twilight").setup()
		end,
	},
	{
		"folke/zen-mode.nvim",
		keys = {
			{
				"<leader>z",
				function()
					require("zen-mode").toggle()
				end,
			},
		},
		dependencies = {
			"folke/twilight.nvim",
		},
		cmd = { "ZenMode" },
		config = function()
			require("zen-mode").setup({})
		end,
	},
}
