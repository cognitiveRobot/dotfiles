return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({})

			-- Installs any that are missing (async, no-op for ones already installed)
			ts.install({
				"lua",
				"r",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"html",
				"vim",
				"regex",
				"sql",
				"dockerfile",
				"toml",
				"json",
				"gitignore",
				"graphql",
				"yaml",
				"make",
				"cmake",
				"markdown",
				"markdown_inline",
				"bash",
			})

			-- Enable highlighting + treesitter indent per filetype
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local map = function(lhs, query)
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end)
			end
			map("af", "@function.outer")
			map("if", "@function.inner")
			map("ac", "@class.outer")
			map("ic", "@class.inner")
		end,
	},

	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup({
				color = "#cfc9c2",
			})
		end,
	},

	{
		"wookayin/semshi", -- use a maintained fork
		ft = "python",
		build = ":UpdateRemotePlugins",
		init = function()
			-- Disable features better provided by LSP or other more general plugins
			vim.g["semshi#error_sign"] = false
			vim.g["semshi#simplify_markup"] = false
			vim.g["semshi#mark_selected_nodes"] = false
			vim.g["semshi#update_delay_factor"] = 0.001

			-- This autocmd must be defined in init to take effect
			vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
				group = vim.api.nvim_create_augroup("SemanticHighlight", { clear = true }),
				callback = function()
					-- Only add style, inherit or link to the LSP's colors
					local set = vim.api.nvim_set_hl
					set(0, "semshiGlobal", { fg = "#61AFEF", bold = true })
					set(0, "semshiImported", { fg = "#61AFEF", bold = true })
					set(0, "semshiParameter", { fg = "#cfcfcf" })
					set(0, "semshiFree", { link = "semshiParameter" })
					set(0, "semshiParameterUnused", { link = "DiagnosticUnnecessary" })
					set(0, "semshiBuiltin", { link = "@function.builtin" })
					set(0, "semshiAttribute", { link = "@attribute" })
					set(0, "semshiSelf", { link = "@lsp.type.selfkeyword" })
					set(0, "semshiUnresolved", { link = "@lsp.type.unresolvedReference" })
				end,
			})
		end,
	},
}
