require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)
-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
-- Appearance of diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		-- Add a custom format function to show error codes
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
	-- Make diagnostic background transparent
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})
-- disalbe commenting next lualine
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--- plugins integration --
require("lazy").setup({
	-- require("plugins.breadcrums"),
	require("plugins.colortheme"),
	require("plugins.snacks"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.formatting"),
	require("plugins.completion"),
	require("plugins.linting"),
	-- require("plugins.cmd-autocomplete"),
	-- require("plugins.autocompletion"),
	-- require("plugins.none-ls"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	-- require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.comment"),
	require("plugins.modes"), --Modes cursor colors
	require("plugins.noice"),
	require("plugins.trouble"),
	require("plugins.iron"),
	-- require("plugins.pyrola"),
	require("plugins.toggleterm"),
	require("plugins.venv-selector"),
	require("plugins.scrollbar"),
	require("plugins.barbeque"),
	-- require("plugins.treesitter-textobjects"),
	-- require("plugins.avante"),
	-- require("plugins.notebook"),
	require("plugins.quarto-jupyter"),
})
vim.cmd.colorscheme("onedark")
--Cursor highlight didn't work
vim.cmd([[highlight CursorLine guibg=#1e1e2e guifg=NONE]])
-- Line Number highlight
vim.api.nvim_set_hl(0, "CursorLineNrAbove", { fg = "blue" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "white", bold = true }) -- { fg = "yellow" })
vim.api.nvim_set_hl(0, "CursorLineNrBelow", { fg = "magenta" })

-- winbar background
vim.api.nvim_set_hl(0, "WinBar", { bg = "#282C34" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#282C34" })
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#31353F" })

-- highlight CellMarker in python file.
-- vim.cmd([[autocmd BufEnter,BufRead *.py call matchadd('CellMarker', '#\s*%%')]])
-- vim.api.nvim_set_hl(0, "CellMarker", { fg = "#ffffff", bg = "#5f5f5f", bold = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.py", "*.ipynb" },
	callback = function()
		vim.fn.matchadd("CellSeparator", "# %%", -1)
		vim.api.nvim_set_hl(0, "CellSeparator", { fg = "#ffffff", bg = "#4a5a83" })
	end,
})
--toggleterm

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

--conda env
-- remove hlsearch highlight
vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "<leader>ce", ":CondaActivate<CR>")
vim.keymap.set("n", "<leader>cd", ":CondaDeactivate<CR>")

vim.g.python3_host_prog = vim.fn.expand("/home/zulfi/anaconda3/bin/python")
