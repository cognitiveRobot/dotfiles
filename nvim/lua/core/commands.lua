vim.o.autoread = true
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "CursorMoved" }, {
vim.api.nvim_create_autocmd({ "FocusGained" }, {
	-- command = "if mode() != 'c' | checktime | endif",
	command = "checktime",
	pattern = "*",
})
local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = { "*" },
	callback = function(_)
		vim.cmd.setlocal("nonumber")
		vim.wo.signcolumn = "no"
		set_terminal_keymaps()
	end,
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
