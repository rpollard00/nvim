return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    init = function()
      -- Enable treesitter highlighting
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
    config = function()
      local ensure_installed = {
        'bicep',
        'c',
        'c_sharp',
        'cpp',
        'eex',
        'elixir',
        'heex',
        'html',
        'go',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'razor',
        'rust',
        'tsx',
        'typescript',
        'vimdoc',
        'vim',
      }

      local already_installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    branch = 'main',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local swap = require('nvim-treesitter-textobjects.swap')

      -- Select textobjects
      vim.keymap.set({ 'o', 'x' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

      -- Move to textobjects
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

      -- Swap textobjects
      vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end, { desc = 'Swap parameter with next' })
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end, { desc = 'Swap parameter with previous' })
    end,
  },
}
