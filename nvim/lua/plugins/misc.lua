-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- Tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = { "Spectre" },
		-- dependencies = {
		--   'nvim-lua/plenary.nvim',
		-- },
	},
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	lazy = false,
	-- 	dependencies = { "MunifTanjim/nui.nvim" },
	-- 	opts = {},
	-- },
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	--event = "VeryLazy",
	-- 	opts = {
	-- 		-- startVisible = true,
	-- 		-- showBlankVirtLine = true,
	-- 		-- highlightColor = { link = "Comment" },
	-- 		-- hints = {
	-- 		--      Caret = { text = "^", prio = 2 },
	-- 		--      Dollar = { text = "$", prio = 1 },
	-- 		--      MatchingPair = { text = "%", prio = 5 },
	-- 		--      Zero = { text = "0", prio = 1 },
	-- 		--      w = { text = "w", prio = 10 },
	-- 		--      b = { text = "b", prio = 9 },
	-- 		--      e = { text = "e", prio = 8 },
	-- 		--      W = { text = "W", prio = 7 },
	-- 		--      B = { text = "B", prio = 6 },
	-- 		--      E = { text = "E", prio = 5 },
	-- 		-- },
	-- 		-- gutterHints = {
	-- 		--     G = { text = "G", prio = 10 },
	-- 		--     gg = { text = "gg", prio = 9 },
	-- 		--     PrevParagraph = { text = "{", prio = 8 },
	-- 		--     NextParagraph = { text = "}", prio = 8 },
	-- 		-- },
	-- 		-- disabled_fts = {
	-- 		--     "startify",
	-- 		-- },
	-- 	},
	-- },
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "echasnovski/mini.icons", version = false },
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
		end,
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
				providers = {
					priority = { "markdown", "lsp", "coc", "norg" },
					markdown = {
						filetypes = { "markdown", "quarto" },
					},
				},
			})
		end,
	},
}
