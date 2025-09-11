return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    modes = {
      diagnostics_buffer = {
        mode = 'diagnostics',
        filter = { buf = 0 },
      },
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>st',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[S]earch/Diagnostics [T]rouble (All)',
    },
    {
      '<leader>sb',
      '<cmd>Trouble diagnostics_buffer toggle<cr>',
      desc = '[S]earch/Diagnostics [B]uffer Trouble',
    },
    {
      '<leader>ss',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = '[S]earch [S]ymbols Trouble',
    },
    {
      '<leader>sl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = '[S]earch [L]SP Trouble',
    },
    {
      '<leader>sL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = '[S]earch [L]ocation List Trouble',
    },
    {
      '<leader>sq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[S]earch [Q]uickfix Trouble',
    },
  },
}
