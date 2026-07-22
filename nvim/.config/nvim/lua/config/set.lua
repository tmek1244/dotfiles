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

-- Nvim ships no detection for Jinja templates, and ansible-language-server only
-- attaches to the compound `yaml.ansible` filetype.

-- Flask keeps its templates in plain `.html` files, so the only way to tell a
-- template from static HTML is to look for Jinja delimiters in the content.
local function html_or_jinja(_, bufnr)
    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 200, false)) do
        if line:find("{%", 1, true) or line:find("{#", 1, true) or line:find("{{", 1, true) then
            return "htmldjango"
        end
    end
    return "html"
end

vim.filetype.add({
    extension = {
        j2 = "jinja",
        jinja = "jinja",
        jinja2 = "jinja",
        html = html_or_jinja,
        htm = html_or_jinja,
    },
    pattern = {
        -- Jinja embedded in HTML, so htmldjango beats plain jinja.
        [".*%.html%.j2"] = "htmldjango",
        [".*%.htm%.j2"] = "htmldjango",

        [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/tasks/main%.ya?ml"] = "yaml.ansible",
        ["playbook%.ya?ml"] = "yaml.ansible",
        ["site%.ya?ml"] = "yaml.ansible",
    },
})

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

