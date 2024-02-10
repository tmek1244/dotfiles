local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({
        hidden = true,
        file_ignore_patterns = {'.git'}
    })
end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.live_grep({
        hidden = true,
        file_ignore_patterns = {'.git'}
    })
end)
vim.keymap.set('n', '<leader>fg', builtin.git_status, {})

local telescope = require('telescope')
telescope.setup({
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
    },
})

