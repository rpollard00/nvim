---@type vim.lsp.Config
return {
  on_attach = function(_, bufnr)
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end,
  commands = {
    ['roslyn.client.peekReferences'] = function()
      local ok, telescope = pcall(require, 'telescope.builtin')
      if ok then
        telescope.lsp_references()
        return
      end

      vim.lsp.buf.references()
    end,
    ['roslyn.client.findReferences'] = function()
      local ok, telescope = pcall(require, 'telescope.builtin')
      if ok then
        telescope.lsp_references()
        return
      end

      vim.lsp.buf.references()
    end,
    ['dotnet.test.run'] = function(command)
      local title = command and command.title or ''
      if title:find 'Run All' then
        pcall(vim.cmd, 'Dotnet test solution')
        return
      end

      pcall(vim.cmd, 'Dotnet test')
    end,
    ['dotnet.test.debug'] = function()
      local ok = pcall(vim.cmd, 'Dotnet testrunner')
      if ok then
        vim.notify('Use easy-dotnet test runner debug mapping to debug the selected test.', vim.log.levels.INFO)
        return
      end

      vim.notify('Debug test CodeLens is not wired for this setup yet.', vim.log.levels.WARN)
    end,
  },
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
      dotnet_enable_tests_code_lens = true,
    },
    ['csharp|background_analysis'] = {
      dotnet_analyzer_diagnostics_scope = 'fullSolution',
      dotnet_compiler_diagnostics_scope = 'fullSolution',
    },
    ['csharp|symbol_search'] = {
      dotnet_search_reference_assemblies = true,
    },
    ['csharp|formatting'] = {
      dotnet_organize_imports_on_format = true,
    },
  },
}
