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
	{
		"rebelot/kanagawa.nvim",
		branch = "master",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
					palette = {
						-- change all usages of these colors
						-- sumiInk0 = "#000000",
						-- fujiWhite = "#FFFFFF",
						oniViolet = "#FF5D62",
						springViolet1 = "#FF5D62",
						sakuraPink = "#FF5D62",
					},
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").load("dark")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				-- use the night style
				style = "night",
				-- disable italic for functions
				styles = {
					functions = {},
				},
				-- Change the "hint" color to the "orange" color, and make the "error" color bright red
				on_colors = function(colors)
					colors.hint = colors.orange
					colors.error = "#ff0000"
				end,
			})
		end,
	},
	{
		"aliqyan-21/darkvoid.nvim",
		config = function()
			require("darkvoid").setup({
				transparent = false,
				glow = false,
				show_end_of_buffer = true,

				colors = {
					fg = "#c0c0c0",
					bg = "#1c1c1c",
					cursor = "#bdfe58",
					line_nr = "#404040",
					visual = "#303030",
					comment = "#585858",
					string = "#d1d1d1",
					func = "#e1e1e1",
					kw = "#f1f1f1",
					identifier = "#b1b1b1",
					type = "#a1a1a1",
					type_builtin = "#c5c5c5", -- current
					-- type_builtin = "#8cf8f7", -- glowy blue old (was present by default before type_builtin was introduced added here for people who may like it)
					search_highlight = "#1bfd9c",
					operator = "#1bfd9c",
					bracket = "#e6e6e6",
					preprocessor = "#4b8902",
					bool = "#66b2b2",
					constant = "#b2d8d8",

					-- enable or disable specific plugin highlights
					plugins = {
						gitsigns = true,
						nvim_cmp = true,
						treesitter = true,
						nvimtree = true,
						telescope = true,
						lualine = true,
						bufferline = true,
						oil = true,
						whichkey = true,
						nvim_notify = true,
					},

					-- gitsigns colors
					added = "#baffc9",
					changed = "#ffffba",
					removed = "#ffb3ba",

					-- Pmenu colors
					pmenu_bg = "#1c1c1c",
					pmenu_sel_bg = "#1bfd9c",
					pmenu_fg = "#c0c0c0",

					-- EndOfBuffer color
					eob = "#3c3c3c",

					-- Telescope specific colors
					border = "#585858",
					title = "#bdfe58",

					-- bufferline specific colors
					bufferline_selection = "#1bfd9c",

					-- LSP diagnostics colors
					error = "#dea6a0",
					warning = "#d6efd8",
					hint = "#bedc74",
					info = "#7fa1c3",
				},
			})
		end,
	},
}
