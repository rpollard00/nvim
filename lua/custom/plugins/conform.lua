return {
  {
    {
      'stevearc/conform.nvim',
      opts = {},
      config = function()
        require('conform').setup {
          formatters_by_ft = {
            lua = { 'stylua' },
            sql = { 'sleek' },
            -- Conform will run multiple formatters sequentially
            python = { 'isort', 'black' },
            -- Use a sub-list to run only the first available formatter
            javascript = { 'prettierd', 'prettier', stop_after_first = true },
            javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            html = { 'prettierd', 'prettier', stop_after_first = true },
          },
          format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
          },
        }
      end,
    },
  },
}
