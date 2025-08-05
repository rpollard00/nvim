vim.keymap.set('n', '<leader>gf', ':Gofmt<CR>')
vim.keymap.set('n', '<leader>cc', ':ClaudeCode<CR>', { desc = 'Launch ClaudeCode' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
--
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

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
--
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
local on_attach = function()
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
  end

  local function toggle_inlay_hints()
    if vim.g.inlay_hints_visible then
      vim.g.inlay_hints_visible = false
      vim.lsp.inlay_hint.enable(false)
    else
      vim.g.inlay_hints_visible = true
      vim.lsp.inlay_hint.enable(true)
    end
  end

  nmap('<leader>ih', toggle_inlay_hints, '[I]nlay [H]ints')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
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
  vim.api.nvim_buf_create_user_command(vim.api.nvim_buf_get_number(0), 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

on_attach()
