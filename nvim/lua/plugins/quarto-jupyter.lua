return {
	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		dev = false,
		opts = {
			lspFeatures = {
				enabled = true,
				chunks = "curly",
			},
			codeRunner = {
				enabled = true,
				default_method = "iron",
			},
		},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- required in which-key plugin spec in plugins/ui.lua as `require 'config.keymap'`
			local wk = require("which-key")
			local ms = vim.lsp.protocol.Methods

			P = vim.print

			vim.g["quarto_is_r_mode"] = nil
			vim.g["reticulate_running"] = false

			local is_code_chunk = function()
				local current, _ = require("otter.keeper").get_current_language_context()
				if current then
					return true
				else
					return false
				end
			end

			--- Insert code chunk of given language
			--- Splits current chunk if already within a chunk
			--- @param lang string
			local insert_code_chunk = function(lang)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
				local keys
				if is_code_chunk() then
					keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
				else
					keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
				end
				keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			end

			local insert_r_chunk = function()
				insert_code_chunk("r")
			end

			local insert_py_chunk = function()
				insert_code_chunk("python")
			end

			--show kepbindings with whichkey
			--add your own here if you want them to
			--show up in the popup as well

			-- normal mode
			wk.add({
				{ "<leader>cc", insert_py_chunk, desc = "code chunk - python" },
				{ "<m-i>", insert_r_chunk, desc = "r code chunk" },
			}, { mode = "n", silent = true })

			-- insert mode
			wk.add({
				{
					mode = { "i" },
					{ "<c-x><c-x>", "<c-x><c-o>", desc = "omnifunc completion" },
					{ "<leader>cc", insert_py_chunk, desc = "code chunk - python" },
					{ "<m-->", " <- ", desc = "assign" },
					{ "<m-m>", " |>", desc = "pipe" },
				},
			}, { mode = "i" })

			local function get_otter_symbols_lang()
				local otterkeeper = require("otter.keeper")
				local main_nr = vim.api.nvim_get_current_buf()
				local langs = {}
				for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
					langs[i] = i .. ": " .. l
				end
				-- promt to choose one of langs
				local i = vim.fn.inputlist(langs)
				local lang = otterkeeper.rafts[main_nr].languages[i]
				local params = {
					textDocument = vim.lsp.util.make_text_document_params(),
					otter = {
						lang = lang,
					},
				}
				-- don't pass a handler, as we want otter to use it's own handlers
				vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
			end

			vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })

			-- local function toggle_conceal()
			-- 	local lvl = vim.o.conceallevel
			-- 	if lvl > DefaultConcealLevel then
			-- 		vim.o.conceallevel = DefaultConcealLevel
			-- 	else
			-- 		vim.o.conceallevel = FullConcealLevel
			-- 	end
			-- end

			-- eval "$(tmux showenv -s DISPLAY)"
			-- normal mode with <leader>
			wk.add({
				{
					-- { "<leader><cr>", send_cell, desc = "run code cell" },
					{ "<leader>e", group = "[e]dit" },
					{ "<leader>e", group = "[t]mux" },
					{ "<leader>fd", [[eval "$(tmux showenv -s DISPLAY)"]], desc = "[d]isplay fix" },
					{ "<leader>h", group = "[h]elp / [h]ide / debug" },
					{ "<leader>hc", group = "[c]onceal" },
					-- { "<leader>hc", toggle_conceal, desc = "[c]onceal toggle" },
					{ "<leader>ht", group = "[t]reesitter" },
					{ "<leader>htt", vim.treesitter.inspect_tree, desc = "show [t]ree" },
					{ "<leader>i", group = "[i]mage" },
					{ "<leader>l", group = "[l]anguage/lsp" },
					{ "<leader>ld", group = "[d]iagnostics" },
					{
						"<leader>ldd",
						function()
							vim.diagnostic.enable(false)
						end,
						desc = "[d]isable",
					},
					{ "<leader>lde", vim.diagnostic.enable, desc = "[e]nable" },
					{ "<leader>le", vim.diagnostic.open_float, desc = "diagnostics (show hover [e]rror)" },
					{ "<leader>o", group = "[o]tter & c[o]de" },
					{ "<leader>oa", require("otter").activate, desc = "otter [a]ctivate" },
					{ "<leader>oc", "O# %%<cr>", desc = "magic [c]omment code chunk # %%" },
					{ "<leader>od", require("otter").activate, desc = "otter [d]eactivate" },
					{ "<leader>op", insert_py_chunk, desc = "[p]ython code chunk" },
					{ "<leader>or", insert_r_chunk, desc = "[r] code chunk" },
					{ "<leader>q", group = "[q]uarto" },
					{
						"<leader>qE",
						function()
							require("otter").export(true)
						end,
						desc = "[E]xport with overwrite",
					},
					{ "<leader>qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
					{ "<leader>qe", require("otter").export, desc = "[e]xport" },
					{ "<leader>qh", ":QuartoHelp ", desc = "[h]elp" },
					{ "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
					{ "<leader>qu", ":lua require'quarto'.quartoUpdatePreview()<cr>", desc = "[u]pdate preview" },
					{ "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
					{ "<leader>qr", group = "[r]un" },
					{ "<leader>qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
					{ "<leader>qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
					{ "<leader>qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },
					{ "<leader>vh", ':execute "h " . expand("<cword>")<cr>', desc = "vim [h]elp for current word" },
					{ "<leader>vl", ":Lazy<cr>", desc = "[l]azy package manager" },
					{ "<leader>vm", ":Mason<cr>", desc = "[m]ason software installer" },
				},
			}, { mode = "n" })
		end,
	},

	{ -- directly open ipynb files as quarto docuements
		-- and convert back behind the scenes
		"GCBallesteros/jupytext.nvim",
		opts = {
			custom_language_formatting = {
				python = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto",
				},
				r = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto",
				},
			},
		},
	},
	{ -- highlight markdown headings and code blocks etc.
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = true,
		ft = { "quarto", "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = { "n", "c", "t" },
			completions = {
				lsp = { enabled = false },
			},
			heading = {
				enabled = false,
			},
			paragraph = {
				enabled = false,
			},
			code = {
				enabled = true,
				style = "full",
				border = "thin",
				sign = false,
				render_modes = { "i", "v", "V" },
			},
			signs = {
				enabled = false,
			},
		},
	},
	{ -- paste an image from the clipboard or drag-and-drop
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		ft = { "markdown", "quarto", "latex" },
		opts = {
			default = {
				dir_path = "img",
			},
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
				quarto = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("img-clip").setup(opts)
			vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
		end,
	},

	{ -- preview equations
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
		},
	},
	-- 	{
	-- 		"nvimtools/hydra.nvim",
	-- 		config = function()
	-- 			-- create hydras in here
	-- 		end,
	-- 	},
	{
		-- see the image.nvim readme for more information about configuring this plugin
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		config = function()
			require("image").setup({
				backend = "kitty",
				processor = "magick_cli", -- or "magick_rock"
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						only_render_image_at_cursor_mode = "popup",
						floating_windows = false, -- if true, images will be rendered in floating markdown windows
						filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
					},
					neorg = {
						enabled = true,
						filetypes = { "norg" },
					},
					typst = {
						enabled = true,
						filetypes = { "typst" },
					},
					html = {
						enabled = false,
					},
					css = {
						enabled = false,
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = {
					"cmp_menu",
					"cmp_docs",
					"snacks_notif",
					"scrollview",
					"scrollview_sign",
				},
				editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
			})
		end,
	},
}
