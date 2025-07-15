return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            show_end_of_buffer = false,
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = { "italic" },
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
            custom_highlights = function(colors)
                return {
                    -- Força fundo sólido em floats
                    NormalFloat = { bg = colors.mantle },
                    FloatBorder = { bg = colors.mantle, fg = colors.surface2 },
                    FloatTitle = { bg = colors.mantle, fg = colors.text },

                    NeoTreeNormal = { bg = colors.mantle },
                    FzfLuaNormal = { bg = colors.mantle, fg = colors.text },
                    FzfLuaBorder = { bg = colors.mantle, fg = colors.surface2 },
                    -- call :Inspect to get this groups
                    -- Highlight group from the plugin

                    --Treesitter groups
                    ["@markup.link.url.markdown_inline"]    = { link = "Special" },
                    ["@markup.link.label.markdown_inline"]  = { link = "WarningMsg" },
                    ["@markup.italic.markdown_inline"]      = { link = "Exception" },
                    ["@markup.raw.markdown_inline"]         = { link = "String" },
                    ["@markup.list.markdown"]               = { link = "Function" },
                    ["@markup.quote.markdown"]              = { link = "Error" },
                    ["@markup.list.checked.markdown"]       = { link = "WarningMsg" },
                }
            end,
        })

        vim.cmd.colorscheme("catppuccin")
    end
}
