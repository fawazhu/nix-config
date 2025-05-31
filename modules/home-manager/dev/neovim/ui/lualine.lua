-- don't show mode as it is in lualine.
vim.opt.showmode = false

local function macro_recording()
    local reg_recording = vim.fn.reg_recording()
    if reg_recording == "" then
        return ""
    else
        return "󰻂 " .. reg_recording
    end
end

require('lualine').setup {
    options = {
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics', macro_recording },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {},
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
}
