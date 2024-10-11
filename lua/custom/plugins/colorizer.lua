return {
  {
    -- COLORIZER plugin
    {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup {
          filetypes = { '*' },
          user_default_options = { names = true },
          buftypes = {},
        }
      end,
    },
  },
}
