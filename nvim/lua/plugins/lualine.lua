return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		--- function to show diagnostics based on window width
		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			-- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
			colored = true,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			-- colored = false,
			colored = true, -- Displays a colored diff status if set to true
			symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
			source = nil, -- A function that works as a data source for diff.
			-- It must return a table as such:
			--   { added = add_count, modified = modified_count, removed = removed_count }
			-- or nil on failure. count <= 0 won't be displayed.
			-- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local env_name = function()
			local name = vim.env.CONDA_DEFAULT_ENV
			return "(" .. name .. ")"
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "sonokai",
				-- theme = "nord", -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch", diff, { env_name, color = { fg = "#58d0ee" } } },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
