return {
    {
        -- COLORIZER plugin
        {
            'NvChad/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup()
            end,
        },
    },
}
