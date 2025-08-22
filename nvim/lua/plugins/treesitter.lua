return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{

			"m-demare/hlargs.nvim",
			config = function()
				require("hlargs").setup({
					color = "#cfc9c2",
				})
			end,
		},
		{
			-- "numiras/semshi",
			"wookayin/semshi", -- use a maintained fork
			ft = "python",
			build = ":UpdateRemotePlugins",
			init = function()
				-- Disabled these features better provided by LSP or other more general plugins
				vim.g["semshi#error_sign"] = false
				vim.g["semshi#simplify_markup"] = false
				vim.g["semshi#mark_selected_nodes"] = false
				vim.g["semshi#update_delay_factor"] = 0.001

				-- This autocmd must be defined in init to take effect
				-- highlight! link semshiParameter @lsp.type.parameter
				vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
					group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
					callback = function()
						-- Only add style, inherit or link to the LSP's colors
						vim.cmd([[
							highlight! semshiglobal guifg=#61AFEF gui=bold
							highlight! semshiimported guifg=#61AFEF gui=bold
							highlight! semshiparameter guifg=#cfcfcf
							highlight! link semshiFree semshiparameter
							highlight! link semshiparameterunused diagnosticunnecessary
							highlight! link semshibuiltin @function.builtin
							highlight! link semshiattribute @attribute
							highlight! link semshiself @lsp.type.selfkeyword
							highlight! link semshiUnresolved @lsp.type.unresolvedReference
							]])
					end,
				})
			end,
		},
	},
	opts = {
		ensure_installed = {
			"lua",
			"python",
			"javascript",
			"typescript",
			-- "vimdoc",
			"vim",
			"regex",
			-- "terraform",
			"sql",
			"dockerfile",
			"toml",
			"json",
			-- "java",
			-- "groovy",
			-- "go",
			-- "gitignore",
			-- "graphql",
			"yaml",
			-- "make",
			-- "cmake",
			"markdown",
			"markdown_inline",
			"bash",
			-- "tsx",
			"css",
			"html",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn", -- set to `false` to disable one of the mappings
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.inner",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.inner",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	},
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	config = function(_, opts)
		local configs = require("nvim-treesitter.configs")
		configs.setup(opts)
	end,
}
