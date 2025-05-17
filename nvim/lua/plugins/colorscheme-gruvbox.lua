return {
	"ellisonleao/gruvbox.nvim",
	opts = {
		contrast = "medium",
		italic = {
			strings = false,
			emphasis = false,
			comments = false,
			operators = false,
			folds = false,
		},
		overrides = {
			SnacksPickerBorder = { link = "GruvboxBlue" },
			NormalFloat = { link = "GruvboxBlue" },
			["@lsp.type.method"] = { bg = "#0000ff" },
			["@comment.lua"] = { bg = "#000000" },
		},
	},
}
