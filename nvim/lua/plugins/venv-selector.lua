return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	},
	opts = {
		search = {
			anaconda_base = {
				command = "fdfind /python$ $HOME/anaconda3/bin --full-path --color never -E /proc",
				type = "anaconda",
			},
			anaconda_envs = {
				command = "fdfind bin/python$ $HOME/anaconda3/envs --full-path --color never -E /proc",
				type = "anaconda",
			},
		},
	},
}
