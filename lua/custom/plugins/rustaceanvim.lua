return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended to pin to tagged releases
  lazy = false, -- This plugin is already lazy by design
  ft = { 'rust' },
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        code_actions = {
          ui_select_fallback = true,
        },
        test_executor = 'background', -- Enable background test running with diagnostics
      },
      -- LSP configuration
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            cargo = { features = 'all' },
            check = { command = 'clippy' },
            interpret = { tests = true },
            -- Code Lens for reference counts above items
            lens = {
              enable = true,
              references = {
                adt = { enable = true }, -- Show references on structs/enums/unions
                enumVariant = { enable = true }, -- Show references on enum variants
                method = { enable = true }, -- Show references on methods
                trait = { enable = true }, -- Show references on traits
              },
              implementations = { enable = true }, -- Show implementation counts
              run = { enable = true }, -- Show run buttons on tests/main
              debug = { enable = true }, -- Show debug buttons
            },
            -- Enhanced inlay hints for better code insights
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 10 },
              closureReturnTypeHints = { enable = 'always' },
              discriminantHints = { enable = 'always' },
              expressionAdjustmentHints = { enable = 'always' },
              implicitDrops = { enable = true },
              lifetimeElisionHints = { enable = 'skip_trivial', useParameterNames = true },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = 'always' },
              renderColons = true,
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
            -- Hover and documentation settings
            hover = {
              actions = { enable = true },
              links = { enable = true },
            },
            -- Completion settings
            completion = {
              callable = { snippets = 'fill_arguments' },
              postfix = { enable = true },
              privateEditable = { enable = true },
            },
          },
        },
      },
      -- DAP configuration
      dap = {
        autoload_configurations = true,
      },
    }
  end,
}