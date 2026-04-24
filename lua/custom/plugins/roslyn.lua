return {
  {
    'GustavEikaas/easy-dotnet.nvim',
    ft = { 'cs', 'razor', 'csproj', 'sln', 'slnx', 'fsproj' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = function()
      return {
        lsp = {
          enabled = true,
          preload_roslyn = true,
        },
        test_runner = {
          viewmode = 'float',
        },
        debugger = {
          auto_register_dap = true,
        },
      }
    end,
    config = function(_, opts)
      require('easy-dotnet').setup(opts)
    end,
  },
  -- {
  --   'GustavEikaas/easy-dotnet.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  --   config = function()
  --     require('easy-dotnet').setup()
  --   end,
  -- },
}
