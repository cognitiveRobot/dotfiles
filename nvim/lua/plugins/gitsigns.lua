return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame_opts = {
			delay = 0,
		},
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		signs_staged = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end
			-- stylua: ignore start
			map("n", "gj", function() gs.nav_hunk("next") end, { desc = "Git Next hunk" })
			map("n", "gk", function() gs.nav_hunk("prev") end, { desc = "Git previous hunk" })
			map("n", "gsh", gs.stage_hunk, { desc = "Stage hunk" })
			map("v", "gsH", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
				{ desc = "Undo stage hunk" })
			-- map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
			-- map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
			--   { desc = "Reset Hunk" })
			map("n", "gsb", gs.stage_buffer, { desc = "Stage buffer" })
			map("n", "gsB", gs.reset_buffer, { desc = "Restore staged buffer" })
			map("n", "gp", gs.preview_hunk, { desc = "Preview hunk" })
			map("n", "gb", gs.toggle_current_line_blame, { desc = "Toggle Blame line" })
			map("n", "gdd", gs.diffthis, { desc = "Diff" })
			map("n", "gsd", gs.preview_hunk_inline, { desc = "Show deleted" })
		end,
	},
	keys = {
		{ "ggg", "", desc = "+Git" },
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)
	end,
}
