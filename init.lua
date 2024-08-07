--[[

====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function set_platform_specific_options()
  if vim.fn.has 'win32' == 1 then
    vim.opt.shellslash = true
    vim.opt.shellcmdflag = '/d'
    -- elseif vim.fn.has("unix") == 1 then
    --   -- set unix/macos only options here
    --   if vim.fn.has("mac") == 1 then
    --     -- mac specific options here
    --   end
  end
end

set_platform_specific_options()

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Girelated plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  {
    'mfussenegger/nvim-dap', -- Install nvim-dap
  },
  {
    'nvim-neotest/nvim-nio',
  },
  {
    'iabdelkareem/csharp.nvim',
    dependencies = {
      'williamboman/mason.nvim', -- Required, automatically installs omnisharp
      'mfussenegger/nvim-dap',
      'Tastyep/structlog.nvim',  -- Optional, but highly recommended for debugging
    },
    config = function()
      require('mason').setup() -- Mason setup must run before csharp
      require('csharp').setup()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'leoluz/nvim-dap-go',
    config = true,
  },

  -- Detect tabstop and  automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        columns = {
          'icon',
        },
      }
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        cmdline = {
          view = 'cmdline',
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = false,
    opts = {

      shade_terminals = false,
    },
    keys = {
      { '<`>', '<cmd>ToggleTerm direction=float<cr>', desc = 'ToggleTerm Float' },
    },
    config = function()
      require('toggleterm').setup()
    end,
  },
  {
    'folke/twilight.nvim',
    opts = {},
  },
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = '+2' },
      },
    },
    keys = { { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' } },
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell,
          -- require("none-ls.diagnostics.eslint"),
          null_ls.builtins.formatting.prettier.with {
            filetypes = {
              'javascript',
              'typescript',
              'typescriptreact',
              'javascriptreact',
              'css',
              'scss',
              'html',
              'json',
              'yaml',
              'markdown',
            },
          },
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
  },
  {
    'folke/flash.nvim',
    enabled = true,
    init = function()
      -- vim.keymap.set("n", "x", "<cmd>lua require('flash').jump()<cr>")
      -- vim.opt.keymap = "emoji"
    end,
    opts = {
      -- labels = "#abcdef",
      modes = {
        -- char = { jump_labels = false },
        -- treesitter = {
        --   label = {
        --     rainbow = { enabled = true },
        --   },
        -- },
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
            -- format = function(opts)
            --   local label = opts.match.label
            --   if opts.after then
            --     label = label .. ">"
            --   else
            --     label = "<" .. label
            --   end
            --   return { { label, opts.hl_group } }
            -- end,
          },
        },
      },
      -- search = { mode = "fuzzy" },
      -- labels = "😅😀🏇🐎🐴🐵🐒",
    },
  },
  -- Flit and Flash Conflict --
  -- Install Flit, Leap, repeat --
  --
  -- {
  --   'tpope/vim-repeat',
  --   'ggandor/leap.nvim',
  --   config = function()
  --     require('leap').create_default_mappings()
  --   end,
  -- },
  -- {
  --   'ggandor/flit.nvim',
  --   dependencies = {
  --     "tpope/vim-repeat",
  --     "ggandor/leap.nvim",
  --   },
  --   config = function()
  --     require('flit').setup {
  --       keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  --       -- A string like "nv", "nvo", "o", etc.
  --       labeled_modes = "v",
  --       multiline = true,
  --       -- Like `leap`s similar argument (call-specific overrides).
  --       -- E.g.: opts = { equivalence_classes = {} }
  --       opts = {}
  --     }
  --   end,
  --
  -- },
  {
    'Wansmer/treesj',
    keys = {
      { 'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup {
  --       sort_by = "case_sensitive",
  --       view = {
  --         width = 30,
  --       },
  --       renderer = {
  --         group_empty = true,
  --       },
  --       filters = {
  --         dotfiles = true,
  --       },
  --     }
  --   end,
  -- },
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {
      plugins = {
        marks = false,
      },
    },
  },
  -- {
  --   'stevearc/conform.nvim',
  --   opts = {},
  --   config = function()
  --     require('conform').setup {
  --       formatters_by_ft = {
  --         lua = { 'stylua' },
  --         -- Conform will run multiple formatters sequentially
  --         python = { 'isort', 'black' },
  --         -- Use a sub-list to run only the first available formatter
  --         javascript = { { 'prettierd', 'prettier' } },
  --         html = { { 'prettierd', 'prettier' } },
  --       },
  --       format_on_save = {
  --         -- These options will be passed to conform.format()
  --         timeout_ms = 500,
  --         lsp_fallback = true,
  --       },
  --     }
  --   end,
  -- },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup()
      vim.keymap.set('n', '<C-t>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-T>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>-', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>=', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
  },
  -- COLORIZER plugin
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      -- vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  -- Themes
  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  -- {
  --   -- Theme inspired by rose-pine
  --   'rose-pine/neovim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'rose-pine'
  --   end,
  -- },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        background = 'dark',
        contrast = 'hard',
        invert_selection = true,
      }

      vim.cmd [[colorscheme gruvbox]]
    end,
    opts = ...,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
--vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Automatically display line diagnostics in hover window
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- Attach bicep lsp to bicep files
vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.bicepparam set filetype=bicep-params ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.tmpl set filetype=html ]]
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>h', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- allow moving selected block in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep cursor centered when jumping half page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- keep search terms centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '`', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '`', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })

-- greatest remap ever, when pasting over a block
-- keep pasting and don't put the replaced term into the buffer
vim.keymap.set('x', '<leader>p', [["_dP]])
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- kill capital Q which quits?
vim.keymap.set('n', 'Q', '@qj')

-- find replace on current word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- create gofmt command
vim.cmd 'command! Gofmt execute "!go fmt %"'
vim.keymap.set('n', '<leader>gf', ':Gofmt<CR>')
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Indent_blankline ]]
require('ibl').setup()
-- require('leap').create_default_mappings()
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local fb_actions = require('telescope').extensions.file_browser.actions

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-c>'] = fb_actions.create,
        ['<C-d>'] = fb_actions.remove,
        ['<C-r>'] = fb_actions.rename,
        ['<C-y>'] = fb_actions.copy,
        ['<C-u>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>pg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>ps', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true, desc = '[F]ile [B]rowser' })
--
-- Debugger Bindings
-- Debug Session Bindings
vim.keymap.set('n', '<leader>dg', function()
  require('dap').continue()
end, { noremap = true, desc = '[D]ebu[g] continue' })
vim.keymap.set('n', '<leader>bp', function()
  require('dap').toggle_breakpoint()
end, { noremap = true, desc = '[B]reak[p]oint toggle' })

-- Debugging Step Mappings
vim.keymap.set('n', '<leader>si', function()
  require('dap').step_into()
end, { noremap = true, silent = true, desc = '[S]tep [I]n (follow execution into functions)' })
vim.keymap.set('n', '<leader>so', function()
  require('dap').step_over()
end, { noremap = true, silent = true, desc = '[S]tep [O]ver (execute the next line)' })
vim.keymap.set('n', '<leader>sn', function()
  require('dap').step_out()
end, { noremap = true, silent = true, desc = '[S]tep [N]ext (continue to the next line in the current scope)' })
vim.keymap.set('n', '<leader>sr', function()
  require('dap').step_out_target()
end, { noremap = true, silent = true, desc = '[S]tep [R]eturn (execute until the current function returns)' })
--
vim.keymap.set('n', '<leader>o', ':Oil<CR>', { noremap = true, desc = '[O]il File Browser' })

-- vim.keymap.set('n', '<leader>sg', function()
-- local builtin = require('telescope.builtin')
--   builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- require 'nvim-treesitter.install'.prefer_git = false
-- require 'nvim-treesitter.install'.compilers = { "zig" }
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'bicep', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  sync_install = false,
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  ignore_install = {},

  highlight = {
    enable = true,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },

  modules = {},
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- vim.api.nvim_set_keymap("i", "<C-sw>", '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
  nmap('<C-i>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  ansiblels = {},
  bicep = {},
  csharp_ls = {},
  cssls = {},
  emmet_language_server = {},
  eslint = {},
  gopls = {},
  html = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  omnisharp = {},
  prettier = {},
  pyright = {},
  rust_analyzer = {},
  terraformls = {},
  tsserver = {},
  typst_lsp = {},
  zls = {},
}

-- Setup neovim lua configuration
require('neodev').setup {
  library = { plugins = { 'nvim-dap-ui' }, types = true },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- linters and non-lsp tools go here for Mason to install
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'netcoredbg',
  'prettier',
  'stylua',
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}

      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

local bicep_lsp_bin = '/usr/local/bin/bicep-langserver/Bicep.LangServer.dll'

require('lspconfig').bicep.setup {
  cmd = { 'dotnet', bicep_lsp_bin },
  filetypes = { 'bicep', 'bicep-params' },
  -- single_file_support = true,
  rootdir = { '.git', 'bicepconfig.json' },
}
-- ToggleTerm Terminal KeyMappings
-- function _G.set_terminal_keymaps()
--   local opts = { buffer = 0 }
--   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--   -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--   -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--   -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--   -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--   -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
--   -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
-- end
--
-- vim.cmd('autocmd! TermOpen term://*toggleterm* lua set_terminal_keymaps()')

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
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
