return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")

            config.setup({
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "css",
                    "json",
                    "jsonc",
                    "markdown",
                    "markdown_inline",
                    "graphql",
                    "bash",
                    "lua",
                    "vim",
                    "yaml",
                    "dockerfile",
                    "gitignore",
                },
                highlight = { enabled = true },
                indent = { enabled = true },
                disable = { "showkeys" },  
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "s", 
                        node_incremental = "s",
                        scope_incremental = false,
                        node_decremental = "S",
                    },
                },
            })
        end
    },{
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependecies = { "nvim-treesitter/nvim-treesitter"},
        config = function() 
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        include_surrounding_whitespace = true,
                    },
                },
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            }
        end
    }
}

