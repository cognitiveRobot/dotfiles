vim.o.autoread = true
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "CursorMoved" }, {
vim.api.nvim_create_autocmd({ "FocusGained" }, {
	-- command = "if mode() != 'c' | checktime | endif",
	command = "checktime",
	pattern = "*",
})
-- :W and :H to set win width/height
vim.api.nvim_create_user_command("W", function(params)
	local width = tonumber(params.fargs[1])
	if not width then
		return
	end
	if math.floor(width) ~= width then
		width = math.floor(width * vim.o.columns)
	end
	vim.api.nvim_win_set_width(0, width)
end, { nargs = 1 })
vim.api.nvim_create_user_command("H", function(params)
	local height = tonumber(params.fargs[1])
	if not height then
		return
	end
	if math.floor(height) ~= height then
		height = math.floor(height * vim.o.lines - vim.o.cmdheight)
	end
	vim.api.nvim_win_set_height(0, height)
end, { nargs = 1 })
