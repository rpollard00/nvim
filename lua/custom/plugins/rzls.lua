return {
  {
    'tris203/rzls.nvim',
    config = require('rzls').setup {
      on_attach = function() end,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    },
  },
}
