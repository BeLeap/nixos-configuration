return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			{
				"<f9>",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<f5>",
				function()
					require("dap").continue()
				end,
			},
			{
				"<f10>",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<f11>",
				function()
					require("dap").step_into()
				end,
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dapui").toggle()
				end,
			},
		},
		config = true,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = true,
	},
}
