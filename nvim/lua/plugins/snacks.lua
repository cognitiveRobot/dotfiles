return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = false },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					layout = {
						preset = "sidebar",
						-- preview = { main = true, enabled = false },
						layout = { position = "right" },
					},
				},
			},
		},
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>g",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer(
                    {layout = { layout = { position = "right" } }}
				)
			end,
			desc = "File Explorer",
		},
	},
}
