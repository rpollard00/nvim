return {
    {
        -- name: gruvbox
        {
            'ellisonleao/gruvbox.nvim',
            priority = 1000,
            config = function()
                require('gruvbox').setup {
                    terminal_colors = true,
                    background = 'dark',
                    contrast = 'hard',
                    invert_selection = true,
                }
                vim.cmd [[colorscheme gruvbox]]
            end,
            opts = ...,
        },
        -- name: onedark
        {
            -- Theme inspired by Atom
            'navarasu/onedark.nvim',
            priority = 1000,
            config = function() end,
        },
        -- name: rose-pine
        {
            -- Theme inspired by rose-pine
            'rose-pine/neovim',
            priority = 1000,
            config = function() end,
        },
    },
}
