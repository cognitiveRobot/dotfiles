return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("lspsaga").setup({})

		vim.keymap.set("n", "<leader>ot", ":Lspsaga outline<CR>")
	end,
}
-- return {
--     "LunarVim/breadcrumbs.nvim",
--         dependencies = {
--             {
--                 "SmiteshP/nvim-navic",
--                 config = function()
--                     require("nvim-navic").setup {
--                         lsp = {
--                             auto_attach = true,
--                         },
--                     }
--                 end
--             },
--         },
--         config = function()
--             require("breadcrumbs").setup()
--         end
-- }
