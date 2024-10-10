return {
    {
        {
            'stevearc/oil.nvim',
            opts = {},
            dependencies = { 'echasnovski/mini.icons' },
            config = function()
                require('oil').setup {
                    default_file_explorer = true,
                    columns = {
                        'icon',
                    },
                }
                vim.keymap.set('n', '<leader>o', ':Oil<CR>', { noremap = true, desc = '[O]il File Browser' })
            end,
        },
    },
}
