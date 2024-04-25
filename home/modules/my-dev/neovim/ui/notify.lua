local notify = require('notify')

notify.setup {
    fps = 60,
    timeout = 1500,
    max_width = 80,
    max_height = 10,
    top_down = false,
}

vim.notify = notify
