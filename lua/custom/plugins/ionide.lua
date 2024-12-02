return {
  {
    'ionide/Ionide-vim',
    ft = { 'fsharp' },
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('lspconfig').fsautocomplete.setup {}
    end,
  },
}
