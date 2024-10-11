-- create gofmt command
vim.cmd 'command! Gofmt execute "!go fmt %"'
vim.keymap.set('n', '<leader>gf', ':Gofmt<CR>')
