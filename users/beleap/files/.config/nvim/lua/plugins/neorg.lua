-- Replace orgmode when GTD done
return {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		cmd = { "Neorg", "Norg" },
		build = ":Neorg sync-parsers",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "hrsh7th/nvim-cmp" },
		},
		opts = {
			load = {
				["core.defaults"] = {},
				["core.keybinds"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							work = "~/notes/work",
							personal = "~/notes/personal",
						},
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
			},
		},
	},
}
