return {
    "LunarVim/breadcrumbs.nvim",
        dependencies = {
            {
                "SmiteshP/nvim-navic",
                config = function()
                    require("nvim-navic").setup {
                        lsp = {
                            auto_attach = true,
                        },
                    }
                end
            },
        },
        config = function()
            require("breadcrumbs").setup()
        end
}
