local dap = require('dap')

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>drr", dap.repl.open)

require('dap-python').setup('python')

dap.adapters.delve = {
    type = 'server',
    port = "''${port}",
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:', '${port}' },
    }
}
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "''${file}"
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "''${file}"
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./''${relativeFileDirname}"
    }
}
