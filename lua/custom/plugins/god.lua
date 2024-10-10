local DEV_MODE = false
local dev_plugins = nil
if DEV_MODE then
    dev_plugins = {
        {
            dir = '~/projects/neovim/plugins/stackmap.nvim',
        },
        {
            dir = '~/projects/neovim/plugins/cutlass.nvim',
        },
    }
end

return {
    {
        -- NOTE: First, some plugins that don't require any configuration
        -- local dev plugins
        dev_plugins or {},

        -- Girelated plugins
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        'tpope/vim-commentary',
        'tpope/vim-repeat',
        -- Detect tabstop and  automatically
        'tpope/vim-sleuth',
        {
            'nvim-lua/plenary.nvim',
        },
        {
            'nvim-neotest/nvim-nio',
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
                        bottom_search = true, -- use a classic bottom cmdline for search
                        command_palette = true, -- position the cmdline and popupmenu together
                        long_message_to_split = true, -- long messages will be sent to a split
                        inc_rename = false, -- enables an input dialog for inc-rename.nvim
                        lsp_doc_border = true, -- add a border to hover docs and signature help
                    },
                }
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
            'seblj/roslyn.nvim',
            ft = 'cs',
            opts = {
                config = {
                    settings = {
                        ['csharp|inlay_hints'] = {
                            csharp_enable_inlay_hints_for_implicit_object_creation = true,
                            csharp_enable_inlay_hints_for_implicit_variable_types = true,
                            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                            csharp_enable_inlay_hints_for_types = true,
                            dotnet_enable_inlay_hints_for_indexer_parameters = true,
                            dotnet_enable_inlay_hints_for_literal_parameters = true,
                            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                            dotnet_enable_inlay_hints_for_other_parameters = true,
                            dotnet_enable_inlay_hints_for_parameters = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                        },
                        ['csharp|code_lens'] = {
                            dotnet_enable_references_code_lens = true,
                        },
                        ['csharp|background_analysis'] = {
                            dotnet_analyzer_diagnostics_scope = 'fullSolution',
                            dotnet_compiler_diagnostics_scope = 'fullSolution',
                        },
                    },
                    on_attach = on_attach,
                },
                -- your configuration comes here; leave empty for default settings
            },
        },
        {
            'Wansmer/treesj',
            keys = {
                { 'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
            },
            opts = { use_default_keymaps = false, max_join_length = 150 },
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
                    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                        { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                    vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                        { buffer = bufnr, desc = '[P]review [H]unk' })
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
            config = function()
                require('ibl').setup()
            end,
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
        { 'numToStr/Comment.nvim', opts = {} },

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
    },
}
