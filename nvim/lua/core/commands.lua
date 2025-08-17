vim.o.autoread = true
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "CursorMoved" }, {
vim.api.nvim_create_autocmd({ "FocusGained" }, {
	-- command = "if mode() != 'c' | checktime | endif",
	command = "checktime",
	pattern = "*",
})
