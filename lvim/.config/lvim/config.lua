-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- general
lvim.log.level = "warn"
lvim.format_on_save = true

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"


lvim.builtin.which_key.mappings.g["s"] = {
  "<cmd>Telescope git_status<cr>", "Git status"
}

lvim.builtin.treesitter.ensure_installed = {
  "python"
}

lvim.builtin.which_key.mappings["v"] = {
  name = "Python",
  e = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "black",
    args = { "--line-length 80" }
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "flake8",
    filetypes = { "python" },
    args = { "--extend-ignore=E203" }
  }
}

lvim.plugins = {
  {
    "AckslD/swenv.nvim",
    "stevearc/dressing.nvim"
  },
}

require('swenv').setup({
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})
