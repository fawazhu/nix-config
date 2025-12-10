local function clear_all_macros()
    local registers_to_clear = "abcdefghijklmnopqrstuvwxyz0123456789"
    local count = 0

    for i = 1, #registers_to_clear do
        local reg = registers_to_clear:sub(i, i)

        -- Get the current content
        local reg_content = vim.fn.getreg(reg)

        -- If it's not empty, clear it
        if reg_content and reg_content ~= "" then
            vim.fn.setreg(reg, "")
            count = count + 1
        end
    end
end

-- Create the final user command :ClearMacros
vim.api.nvim_create_user_command('ClearMacros', clear_all_macros, {
    desc = 'Wipe all named/numbered macros',
})
