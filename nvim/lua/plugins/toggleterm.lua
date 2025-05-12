return {
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	-- toggle terminal from both sides.
	vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>"),
	vim.keymap.set("t", "<leader>tt", [[<Cmd>ToggleTerm<CR>]]),
	-- moving from nvim and terminal keymaps at init.lua
}
