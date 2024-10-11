
-- Automatically display line diagnostics in hover window
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- Attach bicep lsp to bicep files
vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.bicepparam set filetype=bicep-params ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.tmpl set filetype=html ]]
