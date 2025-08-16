# Agent Guidelines for Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua**: `stylua .` - format all Lua files using StyLua configuration
- **Start Neovim**: `nvim` - test configuration by launching Neovim
- **Check syntax**: Open Neovim and run `:checkhealth` to verify plugin status
- **Single test**: N/A - this is a Neovim config, test by loading specific plugins

## Code Style Guidelines

### File Structure
- Plugin configs in `lua/custom/plugins/` with descriptive filenames
- Core setup in `lua/setup/` for platform-specific configurations
- Use `init.lua` in the root for bootstrap and main configuration

### Lua Conventions
- **Indentation**: 2 spaces (matches .stylua.toml)
- **Quotes**: Single quotes preferred (auto-prefer-single in StyLua)
- **Function calls**: No parentheses for single string/table arguments
- **Line width**: 160 characters maximum
- **Table formatting**: Use trailing commas for multi-line tables

### Plugin Configuration Pattern
```lua
return {
  'plugin/name',
  dependencies = { 'dep1', 'dep2' },
  config = function()
    require('plugin').setup {}
  end,
}
```

### Error Handling
- Use `vim.notify()` for user-facing messages
- Wrap potentially failing operations in pcall when appropriate
- Follow Neovim's diagnostic and LSP error reporting patterns