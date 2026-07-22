-- mapleader is set in config/lazy.lua, before lazy.nvim loads.
vim.g.editorconfig = false

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "79"

vim.opt.splitright = true

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Strip trailing whitespace on save. `keeppatterns` stops the substitution from
-- landing in the search register, winsaveview keeps the scroll position too.
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = { "*" },
    callback = function()
        if not vim.bo.modifiable or vim.bo.buftype ~= "" then return end
        local view = vim.fn.winsaveview()
        vim.cmd [[keeppatterns %s/\s\+$//e]]
        vim.fn.winrestview(view)
    end
})

