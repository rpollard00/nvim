return {
    {
        {
            'akinsho/toggleterm.nvim',
            version = '*',
            lazy = false,
            opts = {

                shade_terminals = false,
            },
            config = function()
                require('toggleterm').setup()
                vim.keymap.set('n', '`', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })
                vim.keymap.set('t', '`', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })
                -- ToggleTerm Terminal KeyMappings
                -- function _G.set_terminal_keymaps()
                --   local opts = { buffer = 0 }
                --   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                --   -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                --   -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                --   -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                --   -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                --   -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                --   -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
                -- end
                --
                -- vim.cmd('autocmd! TermOpen term://*toggleterm* lua set_terminal_keymaps()')
            end,
        },
    },
}
