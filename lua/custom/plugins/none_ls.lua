return {
    {
        {
            'nvimtools/none-ls.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            config = function()
                local null_ls = require 'null-ls'

                null_ls.setup {
                    sources = {
                        null_ls.builtins.formatting.stylua,
                        null_ls.builtins.completion.spell,
                        -- require("none-ls.diagnostics.eslint"),
                        null_ls.builtins.formatting.prettier.with {
                            filetypes = {
                                'javascript',
                                'typescript',
                                'typescriptreact',
                                'javascriptreact',
                                'css',
                                'scss',
                                'html',
                                'json',
                                'yaml',
                                'markdown',
                            },
                        },
                    },
                }
            end,
        },
    },
}
