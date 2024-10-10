return {
    {
        {
            'mfussenegger/nvim-dap', -- Install nvim-dap
            config = function()
                vim.keymap.set('n', '<leader>dg', function()
                    require('dap').continue()
                end, { noremap = true, desc = '[D]ebu[g] continue' })
                vim.keymap.set('n', '<leader>bp', function()
                    require('dap').toggle_breakpoint()
                end, { noremap = true, desc = '[B]reak[p]oint toggle' })

                -- Debugging Step Mappings
                vim.keymap.set('n', '<leader>si', function()
                    require('dap').step_into()
                end, { noremap = true, silent = true, desc = '[S]tep [I]n (follow execution into functions)' })
                vim.keymap.set('n', '<leader>so', function()
                    require('dap').step_over()
                end, { noremap = true, silent = true, desc = '[S]tep [O]ver (execute the next line)' })
                vim.keymap.set('n', '<leader>sn', function()
                    require('dap').step_out()
                end,
                    { noremap = true, silent = true, desc =
                    '[S]tep [N]ext (continue to the next line in the current scope)' })
                vim.keymap.set('n', '<leader>sr', function()
                    require('dap').step_out_target()
                end,
                    { noremap = true, silent = true, desc =
                    '[S]tep [R]eturn (execute until the current function returns)' })
            end,
        },
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                require('dapui').setup()
                local dap, dapui = require 'dap', require 'dapui'
                dap.listeners.before.attach.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    dapui.close()
                end
            end,
        },
        {
            'leoluz/nvim-dap-go',
            config = true,
        },
    },
}
