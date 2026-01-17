return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"j-hui/fidget.nvim",
			opts = {},
		},
		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

				-- map("n", "K", vim.lsp.buf.hover, "Hover info")
				-- map("gr", vim.lsp.buf.references, "References")
				-- map("gd", vim.lsp.buf.definition, "Go to definition")
				-- -- WARN: This is not Goto Definition, this is Goto Declaration.
				-- --  For example, in C this would take you to the header.
				-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				-- map("gI", vim.lsp.buf.implementation, "Goto Implementation")
				-- map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
				-- map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
				-- map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.

				-- {
				-- 	"<leader>ss",
				-- 	function()
				-- 		Snacks.picker.lsp_symbols()
				-- 	end,
				-- 	desc = "LSP Symbols",
				-- },
				-- {
				-- 	"<leader>sS",
				-- 	function()
				-- 		Snacks.picker.lsp_workspace_symbols()
				-- 	end,
				-- 	desc = "LSP Workspace Symbols",
				-- },
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = true },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				prefix = "●",
				underline = false,
				update_in_insert = true,
				float = {
					source = true,
				},
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		-- Diagnostic keymaps
		vim.keymap.set("n", "dj", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { desc = "Previous diagnostic message" })
		vim.keymap.set("n", "dk", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { desc = "Next diagnostic message" })
		vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
		vim.keymap.set("n", "<leader>dh", function()
			vim.diagnostic.enable(false)
		end, { desc = "Diagnostic message hide" })
		vim.keymap.set("n", "<leader>de", vim.diagnostic.enable, { desc = "Diagnostic enable" })
		-- NOTE: there some more keymaps @trouble.lua plugin.
		--
		local servers = {
			ruff = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								maxLineLength = 100, -- This sets how long the line is allowed to be. Also has effect on formatter.
								ignore = { "E303" },
							},
							pyflakes = { enabled = false },
						},
					},
				},
			},
		}
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"tailwindcss-language-server",
				"typescript-language-server",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- require("mason-lspconfig").setup({
		-- 	automatic_enable = vim.tbl_keys(servers or {}),
		-- })
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		for server_name, config in pairs(servers) do
			config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			vim.lsp.config(server_name, config)
			vim.lsp.enable(server_name)
		end
	end,
}
