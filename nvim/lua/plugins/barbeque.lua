return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		-- "neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		-- config = function()
		-- 	require("nvim-navic").setup({
		-- 		lsp = {
		-- 			auto_attach = true,
		-- 			preference = { "pylsp" },
		-- 		},
		-- 	})
		-- end,
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		-- configurations go here
	},
	-- init = function()
	-- 	-- Manually configure nvim-navic to only attach to pylsp
	-- 	require("nvim-navic").setup({
	-- 		lsp = {
	-- 			auto_attach = true, -- Let navic auto-attach (but filter below)
	-- 			preference = { "pylsp" }, -- Only prefer pylsp
	-- 		},
	-- 	})
	--
	-- 	-- Override LSP on_attach to ensure navic only binds to pylsp
	-- 	local lspconfig = require("lspconfig")
	-- 	local navic = require("nvim-navic")
	--
	-- 	-- Check if the LSP is pylsp before attaching navic
	-- 	local custom_attach = function(client, bufnr)
	-- 		if client.name == "pylsp" then
	-- 			navic.attach(client, bufnr)
	-- 		end
	-- 	end
	-- 	--
	-- 	-- -- Apply to pylsp (if not already managed by LazyVim)
	-- 	lspconfig.pylsp.setup({
	-- 		on_attach = custom_attach,
	-- 	})
	-- end,
}
