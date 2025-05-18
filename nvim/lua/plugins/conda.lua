return {
	"kmontocam/nvim-conda",
	dependencies = { "nvim-lua/plenary.nvim" },
}
-- To show on the lualine add the function in lualine.lua
-- then add env_name in the section where you want to show.
-- local env_name = function()
-- 	local name = vim.env.CONDA_DEFAULT_ENV
-- 	return "(" .. name .. ")"
-- end
