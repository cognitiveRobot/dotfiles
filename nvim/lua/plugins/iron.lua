return {
	-- "Vigemus/iron.nvim",
	"cognitiveRobot/iron.nvim",
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		iron.setup({
			config = {
				ignore_blank_lines = true,
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" },
					},
					python = {
						command = {
							"ipython",
							"--no-autoindent",
							"-i",
							"-c",
							"import IPython; ip=IPython.get_ipython(); ip.run_line_magic('load_ext','autoreload'); ip.run_line_magic('autoreload','2')",
						}, -- or {"python3", "ipython", "--no-autoindent" }
						format = common.bracketed_paste,
						block_dividers = { "# %%", "#%%" },
					},
					quarto = {
						command = {
							"ipython",
							"--no-autoindent",
							"-i",
							"-c",
							"import IPython; ip=IPython.get_ipython(); ip.run_line_magic('load_ext','autoreload'); ip.run_line_magic('autoreload','2')",
						}, -- or {"python3", "ipython", "--no-autoindent" }
						format = common.bracketed_paste,
						block_dividers = { "```{", "```" },
					},
					r = {
						command = {
							"radian"
						}, -- or {"python3", "ipython", "--no-autoindent" }
						format = common.bracketed_paste,
						block_dividers = { "```{", "```" },
					},
					rmd = {
						command = {
							"radian"
						}, -- or {"python3", "ipython", "--no-autoindent" }
						format = common.bracketed_paste,
						block_dividers = { "```{", "```" },
					},
				},
				-- set the file type of the newly created repl to ft
				-- bufnr is the buffer id of the REPL and ft is the filetype of the
				-- language being used for the REPL.
				-- repl_filetype = function(bufnr, ft)
				-- 	return ft
				-- 	-- or return a string name such as the following
				-- 	-- return "iron"
				-- end,
				-- How the repl window will be displayed
				-- See below for more information
				--- repl_open_cmd = view.bottom(40),
				repl_open_cmd = view.split.vertical.rightbelow("%40"),

				-- repl_open_cmd can also be an array-style table so that multiple
				-- repl_open_commands can be given.
				-- When repl_open_cmd is given as a table, the first command given will
				-- be the command that `IronRepl` initially toggles.
				-- Moreover, when repl_open_cmd is a table, each key will automatically
				-- be available as a keymap (see `keymaps` below) with the names
				-- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
				-- For example,
				--
				-- repl_open_cmd = {
				--   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
				--   view.split.rightbelow("%25")  -- cmd_2: open a repl below
				-- }
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				toggle_repl = "<space>rr", -- toggles the repl open and closed.
				-- If repl_open_command is a table as above, then the following keymaps are
				-- available
				-- toggle_repl_with_cmd_1 = "<space>rv",
				-- toggle_repl_with_cmd_2 = "<space>rh",
				restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
				-- send_motion = "<space>sc",
				visual_send = "<space>rv",
				-- send_file = "<space>rf",
				send_line = "<space>ll",
				send_paragraph = "<space>rp",
				send_until_cursor = "<space>rc",
				send_mark = "<space>rm",
				send_code_block = "<space><cr>",
				send_code_block_and_move = "<space><cr>m",
				-- mark_motion = "<space>mc",
				-- mark_visual = "<space>mc",
				-- remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- Function to send `type(<word>)` to REPL
		local send_word_for = function(key)
			-- Get word under cursor
			local word = vim.fn.expand("<cword>")
			-- Build command
			local cmd = ""
			if key == "type" then
				cmd = "type(" .. word .. ")"
			elseif key == "col" then
				cmd = word .. ".columns"
			elseif key == "info" then
				cmd = word .. ".info()"
			elseif key == "len" then
				cmd = "len(" .. word .. ")"
			else
				cmd = ""
			end
			-- Send to REPL
			iron.send(nil, { cmd })
		end

		-- Keymap example: <leader>tw
		vim.keymap.set("n", "<leader>ty", function()
			send_word_for("type")
		end, { noremap = true, silent = true, desc = "type of under cursor word" })
		vim.keymap.set("n", "<leader>co", function()
			send_word_for("col")
		end, { noremap = true, silent = true, desc = ".columns of under cursor word" })
		vim.keymap.set("n", "<leader>in", function()
			send_word_for("info")
		end, { noremap = true, silent = true, desc = ".info() of under cursor word" })
		vim.keymap.set("n", "<leader>le", function()
			send_word_for("len")
		end, { noremap = true, silent = true, desc = "len of under cursor word" })

		vim.keymap.set("n", "<leader>k", "viw<leader>rv", { remap = true, silent = true })
		vim.keymap.set(
			"n",
			"<space><cr><cr>",
			"<space><cr>mN",
			{ remap = true, silent = true, desc = "Send code block and go to the next." }
		)

		vim.keymap.set("n", "<leader>3", "o<Esc>i# %%<Esc>o", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>4", "o<Esc>i# %% [markdown]<Esc>o", { noremap = true, silent = true })
		local goto_next_code_cell = function()
			if vim.bo[0].filetype == "quarto" then
				vim.cmd("call search('^```{', 'W')")
			else
				vim.cmd("call search('^# %%', 'W')")
			end
		end
		local goto_prev_code_cell = function()
			if vim.bo[0].filetype == "quarto" then
				vim.cmd("call search('^```{', 'bW')")
			else
				vim.cmd("call search('^# %%', 'bW')")
			end
		end
		vim.keymap.set("n", "N", goto_next_code_cell, { noremap = true, silent = true })
		vim.keymap.set("n", "P", goto_prev_code_cell, { noremap = true, silent = true })
		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
		vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
	end,
}
