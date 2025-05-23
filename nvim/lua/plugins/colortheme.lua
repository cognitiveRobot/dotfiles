return {
	{

		--- https://github.com/shaunsingh/nord.nvim
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Example config in lua
			vim.g.nord_contrast = true
			vim.g.nord_borders = false
			vim.g.nord_disable_background = false
			vim.g.nord_italic = false
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = false

			-- Load the colorscheme
			-- require("nord").set()
		end,
	},
	{
		-- https://github.com/sainnhe/sonokai/tree/master?tab=readme-ov-file
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_style = "andromeda"
			vim.g.sonokai_cursor = "green"
			-- vim.cmd.colorscheme("sonokai")

			local toggle_background = function()
				vim.g.sonokai_transparent_background = not vim.g.sonokai_transparent_background
				-- vim.cmd.colorscheme("sonokai")
			end

			vim.keymap.set("n", "<leader>bg", toggle_background, { noremap = true, silent = true })
		end,
	},
	{
		"cognitiverobot/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "dark",
				-- style = "darker",
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.g.material_style = "deep ocean"
			-- vim.cmd.colorscheme("material")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			contrast = "medium",
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			overrides = {
				SnacksPickerBorder = { link = "GruvboxBlue" },
				NormalFloat = { link = "GruvboxBlue" },
				["@lsp.type.method"] = { bg = "#0000ff" },
				["@comment.lua"] = { bg = "#000000" },
			},
		},
	},
}
