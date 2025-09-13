return {
  'yioneko/nvim-vtsls',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  ft = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  config = function()
    local vtsls = require 'vtsls'
    local lspconfig = require 'lspconfig'

    -- Configure vtsls through lspconfig to work with Mason
    lspconfig.vtsls.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
              entriesLimit = 200,
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          preferences = {
            includePackageJsonAutoImports = 'on',
            importModuleSpecifier = 'shortest',
          },
          inlayHints = {
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = false },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          preferences = {
            includePackageJsonAutoImports = 'on',
            importModuleSpecifier = 'shortest',
          },
          inlayHints = {
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = false },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
    }

    -- Enhanced diagnostics configuration
    vim.diagnostic.config {
      virtual_text = {
        prefix = '●',
        source = 'if_many',
        spacing = 2,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN] = '▲',
          [vim.diagnostic.severity.HINT] = '⚑',
          [vim.diagnostic.severity.INFO] = '»',
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    }

    -- TypeScript specific keymaps
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        if client.name == 'vtsls' then
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'TypeScript: ' .. desc })
          end

          -- TypeScript specific commands
          map('<leader>co', function()
            vim.lsp.buf.execute_command {
              command = 'typescript.organizeImports',
              arguments = { vim.api.nvim_buf_get_name(0) },
            }
          end, 'Organize Imports')

          map('<leader>cR', function()
            vtsls.commands.rename_file()
          end, 'Rename File')

          map('<leader>cu', function()
            vim.lsp.buf.execute_command {
              command = 'typescript.removeUnusedImports',
              arguments = { vim.api.nvim_buf_get_name(0) },
            }
          end, 'Remove Unused Imports')

          map('<leader>cs', function()
            vim.lsp.buf.execute_command {
              command = 'typescript.sortImports',
              arguments = { vim.api.nvim_buf_get_name(0) },
            }
          end, 'Sort Imports')

          map('<leader>cA', function()
            vim.lsp.buf.execute_command {
              command = 'typescript.addMissingImports',
              arguments = { vim.api.nvim_buf_get_name(0) },
            }
          end, 'Add Missing Imports')

          map('<leader>cf', function()
            vtsls.commands.fix_all()
          end, 'Fix All')

          map('<leader>cS', function()
            vtsls.commands.select_ts_version()
          end, 'Select TypeScript Version')

          map('<leader>cL', function()
            vtsls.commands.open_ts_server_log()
          end, 'Open TS Server Log')

          map('<leader>cr', function()
            vtsls.commands.restart_tsserver()
          end, 'Restart TS Server')

          map('<leader>cg', function()
            vtsls.commands.goto_source_definition(0)
          end, 'Go to Source Definition')

          map('<leader>cF', function()
            vtsls.commands.file_references()
          end, 'File References')

          -- Enable inlay hints if supported
          if client.supports_method 'textDocument/inlayHint' then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end
      end,
    })
  end,
}