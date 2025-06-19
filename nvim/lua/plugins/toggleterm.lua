return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- direction = "vertical",
				direction = "float",
				float_opts = {
					width = 140,
					height = 50,
				},
			})
			local change_height = function()
				vim.g.toggleterm.float_opts.height = vim.g.toggleterm.float_opts.height - 5
			end
			vim.keymap.set("t", "<ctrl><DOWN>", change_height)
		end,
	},

	-- toggle terminal from both sides.
	vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>"),
	vim.keymap.set("t", "<leader>tt", [[<Cmd>ToggleTerm<CR>]]),
}
-- return {
-- 	{ "akinsho/toggleterm.nvim", version = "*", config = true },
-- 	-- toggle terminal from both sides.
-- 	vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>"),
-- 	vim.keymap.set("t", "<leader>tt", [[<Cmd>ToggleTerm<CR>]]),
-- 	-- moving from nvim and terminal keymaps at init.lua
-- }
