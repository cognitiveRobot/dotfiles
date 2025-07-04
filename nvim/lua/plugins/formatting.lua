return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					lua = { "stylua" },
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
					-- javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					-- typescript = { "prettierd", "prettier", stop_after_first = true },
					-- typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					graphql = { "prettierd", "prettier", stop_after_first = true },
					python = {
						-- To fix auto-fixable lint errors.
						-- "ruff_fix",
						"ruff_format",
						-- To organize the imports.
						"ruff_organize_imports",
					},
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters = {
					ruff_format = {
						inherit = false,
						command = "ruff",
						args = {
							"format",
							"$FILENAME",
							"--line-length=100",
							"--stdin-filename",
							"$FILENAME",
						},
					},
				},
			})
		end,
		-- vim.keymap.set("", "<leader>fm", function()
		-- 	require("conform").format({ async = true, lsp_fallback = true })
		-- end, { desc = "[F]ormat" }),
		vim.keymap.set("", "<leader>fm", function()
			require("conform").format({ async = true, lsp_fallback = true }, function(err)
				if not err then
					local mode = vim.api.nvim_get_mode().mode
					if vim.startswith(string.lower(mode), "v") then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
					end
				end
			end)
		end, { desc = "Format code" }),
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
