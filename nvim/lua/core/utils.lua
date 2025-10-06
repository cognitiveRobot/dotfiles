-- Function to search Google for selected text
local function google_search()
	-- get the visually selected text
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		return
	end

	-- yank selected text to a variable
	vim.cmd('normal! "vy')
	local query = vim.fn.getreg("v")
	query = query:gsub("%s+", "+") -- replace spaces with '+'

	-- escape shell characters
	query = vim.fn.shellescape(query)

	-- build the command
	local url = "https://www.google.com/search?q=" .. query

	-- open in default browser (Linux/macOS/WSL). Change if on Windows.
	vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

-- Keymap in visual mode: <leader>sg (search google)
vim.keymap.set("v", "<leader>sg", google_search, { desc = "Search Google for selection" })
