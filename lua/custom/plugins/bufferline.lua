return {
    {
        {
            'akinsho/bufferline.nvim',
            version = '*',
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('bufferline').setup()
                vim.keymap.set('n', '<C-t>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<C-T>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>-', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>=', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })
            end,
        },
    },
}
