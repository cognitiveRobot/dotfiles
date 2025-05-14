return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 40,
				relativenumber = true,
				side = "right",
			},
			sync_root_with_cwd = true,
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "›",
							arrow_open = "⌄",
						},
						git = {
							staged = "A",
							unstaged = "M",
							unmerged = "!",
							renamed = "R",
							untracked = "U",
							deleted = "D",
							ignored = "◌",
						},
					},
					git_placement = "after",
					modified_placement = "after",
					webdev_colors = true,
				},
				highlight_git = true,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				dotfiles = true,
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})
		-- uncomment below to set custom highlight color
		-- Get command names from here https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L2554
		-- vim.cmd.highlight("NvimTreeGitFileNewHL guifg=#56d364")

		-- highlight the file on nvim-tree after moving from the file.
		local api = require("nvim-tree.api")

		vim.api.nvim_create_autocmd("BufEnter", {
			nested = true,
			callback = function()
				if vim.fn.bufname() == "NvimTree_1" then
					return
				end

				api.tree.find_file({ buf = vim.fn.bufnr() })
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
