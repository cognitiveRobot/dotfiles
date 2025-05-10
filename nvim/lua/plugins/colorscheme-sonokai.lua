return {
	-- https://github.com/sainnhe/sonokai/tree/master?tab=readme-ov-file
	"sainnhe/sonokai",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.sonokai_enable_italic = true
		vim.g.sonokai_style = "andromeda"
		vim.g.sonokai_cursor = "green"
		vim.cmd.colorscheme("sonokai")

		local toggle_background = function()
			vim.g.sonokai_transparent_background = not vim.g.sonokai_transparent_background
			vim.cmd.colorscheme("sonokai")
		end

		vim.keymap.set("n", "<leader>bg", toggle_background, { noremap = true, silent = true })
	end,
}
