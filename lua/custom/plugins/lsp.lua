return {
  {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    config = function()
      local neocodeium = require 'neocodeium'
      neocodeium.setup()
      -- Keybindings to accept suggestions in insert mode
      vim.keymap.set('i', '<A-f>', neocodeium.accept)
      -- Smart C-y: prioritize ghost text over cmp completions
      vim.keymap.set('i', '<C-y>', function()
        local cmp = require 'cmp'
        -- Check if neocodeium has an active ghost text suggestion
        local has_ghost_text = neocodeium.visible and neocodeium.visible()
          or (vim.b.neocodeium_compl ~= nil and vim.b.neocodeium_compl ~= '')
        if has_ghost_text then
          neocodeium.accept()
        elseif cmp.visible() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
        end
      end)
    end,
  },
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'eslint',
          'gopls',
          'html',
          'cssls',
          'emmet_language_server',
          'vtsls',
          'zls',
        },
        automatic_enable = true,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  {
    { -- optional completion source for require statements and module annotations
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'prettierd',
          'stylua',
        },
      }
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<Enter>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'easy-dotnet' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'neocodeium' }, -- Windsurf AI completions
        },
      }
    end,
  },
}
