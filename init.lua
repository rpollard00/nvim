-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'setup.platform_options'
require 'setup.debug'
require 'kickstart.plugins.autoformat'

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

require('lazy').setup({ import = 'custom/plugins' }, {
  change_detection = {
    notify = false,
  },
})

vim.cmd [[colorscheme gruvbox]]

-- require('cutlass').setup()
-- NOTE: You can change these options as you wish!

-- Automatically display line diagnostics in hover window
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- Attach bicep lsp to bicep files
vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.bicepparam set filetype=bicep-params ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.tmpl set filetype=html ]]
-- [[ Basic Keymaps ]]

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

-- require('leap').create_default_mappings()

-- vim.keymap.set('n', '<leader>sg', function()
-- local builtin = require('telescope.builtin')
--   builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

-- Setup neovim lua configuration
-- require('neodev').setup {
--   library = { plugins = { 'nvim-dap-ui' }, types = true },
-- }
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers

local bicep_lsp_bin = '/usr/local/bin/bicep-langserver/Bicep.LangServer.dll'

require('lspconfig').bicep.setup {
  cmd = { 'dotnet', bicep_lsp_bin },
  filetypes = { 'bicep', 'bicep-params' },
  -- single_file_support = true,
  rootdir = { '.git', 'bicepconfig.json' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
