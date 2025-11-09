return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'

      -- Check if expert config already exists, if not create it
      if not configs.expert then
        configs.expert = {
          default_config = {
            filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
            cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/expert', '--stdio' },
            root_dir = function(fname)
              return lspconfig.util.root_pattern('mix.exs', '.git')(fname) or vim.loop.os_homedir()
            end,
            settings = {},
          },
        }
      end

      lspconfig.expert.setup {
        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Keybindings for LSP functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, bufopts)
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
    end,
  },
}
