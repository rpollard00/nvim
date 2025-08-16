local bufnr = vim.api.nvim_get_current_buf()

-- Enhanced LSP keymaps that override/extend standard ones for Rust
vim.keymap.set('n', '<leader>a', function()
  vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr, desc = 'Code Action' })

vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp({'hover', 'actions'})
end, { silent = true, buffer = bufnr, desc = 'Hover Actions' })

-- Rust-specific features using <leader>r prefix
vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp('run')
end, { silent = true, buffer = bufnr, desc = '[R]ust [R]un' })

vim.keymap.set('n', '<leader>rt', function()
  vim.cmd.RustLsp('testables')
end, { silent = true, buffer = bufnr, desc = '[R]ust [T]estables' })

vim.keymap.set('n', '<leader>rd', function()
  vim.cmd.RustLsp('debug')
end, { silent = true, buffer = bufnr, desc = '[R]ust [D]ebug' })

vim.keymap.set('n', '<leader>re', function()
  vim.cmd.RustLsp('explainError')
end, { silent = true, buffer = bufnr, desc = '[R]ust [E]xplain Error' })

vim.keymap.set('n', '<leader>rm', function()
  vim.cmd.RustLsp('expandMacro')
end, { silent = true, buffer = bufnr, desc = '[R]ust Expand [M]acro' })

vim.keymap.set('n', '<leader>rc', function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr, desc = '[R]ust Open [C]argo.toml' })

vim.keymap.set('n', '<leader>rp', function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr, desc = '[R]ust [P]arent Module' })

vim.keymap.set('n', '<leader>rj', function()
  vim.cmd.RustLsp('joinLines')
end, { silent = true, buffer = bufnr, desc = '[R]ust [J]oin Lines' })

vim.keymap.set('n', '<leader>rh', function()
  vim.cmd.RustLsp({ 'view', 'hir' })
end, { silent = true, buffer = bufnr, desc = '[R]ust View [H]IR' })

vim.keymap.set('n', '<leader>rM', function()
  vim.cmd.RustLsp({ 'view', 'mir' })
end, { silent = true, buffer = bufnr, desc = '[R]ust View [M]IR' })

vim.keymap.set('n', '<leader>rs', function()
  vim.cmd.RustLsp('ssr')
end, { silent = true, buffer = bufnr, desc = '[R]ust [S]tructural Search Replace' })

vim.keymap.set('n', '<leader>rR', function()
  vim.cmd.RustLsp('renderDiagnostic')
end, { silent = true, buffer = bufnr, desc = '[R]ust [R]ender Diagnostic' })

vim.keymap.set('n', '<leader>rl', function()
  vim.cmd.RustLsp({ 'flyCheck', 'run' })
end, { silent = true, buffer = bufnr, desc = '[R]ust [L]int (Fly Check)' })

-- Move item up/down
vim.keymap.set('n', '<A-Up>', function()
  vim.cmd.RustLsp({ 'moveItem', 'up' })
end, { silent = true, buffer = bufnr, desc = 'Move Item Up' })

vim.keymap.set('n', '<A-Down>', function()
  vim.cmd.RustLsp({ 'moveItem', 'down' })
end, { silent = true, buffer = bufnr, desc = 'Move Item Down' })