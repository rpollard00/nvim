local function set_platform_specific_options()
    if vim.fn.has 'win32' == 1 then
        vim.opt.shellslash = true
        vim.opt.shellcmdflag = '/d'
        -- elseif vim.fn.has("unix") == 1 then
        --   -- set unix/macos only options here
        --   if vim.fn.has("mac") == 1 then
        --     -- mac specific options here
        --   end
    end
end

set_platform_specific_options()
