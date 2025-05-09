return {
  manual_install = true,
  cmd = { 'dune', 'exec', 'ocamllsp' },
  settings = {
    codelens = { enable = true },
    inlayHints = { enable = true },
    syntaxDocumentation = { enable = true },
  },
  server_capabilities = {
    semanticTokensProvider = false,
  },
}
