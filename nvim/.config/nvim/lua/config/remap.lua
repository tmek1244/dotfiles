-- LunarVim config
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-s>", ":w<cr>", opts)
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", opts)

vim.keymap.set("n", "<C-h>", ":KittyNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", ":KittyNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", ":KittyNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-l>", ":KittyNavigateRight<CR>", opts)

vim.keymap.set("n", "<leader>q", ":q<cr>", opts)
vim.keymap.set("n", "<Esc>", ":nohlsearch<cr>", opts)
-- Primeagen config

vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("x", "<leader>p", "\"_dP", opts)

-- requires xclip if using X11 or wl-clipboard for wayland
vim.keymap.set("n", "<leader>y", "\"+y", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)
vim.keymap.set("n", "<leader>Y", "\"+Y", opts)

vim.keymap.set("n", "<leader>d", "\"_d", opts)
vim.keymap.set("v", "<leader>d", "\"_d", opts)

vim.keymap.set("n", "Q", "<nop>", opts)

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)


vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Tab pages hold window layouts, not files: one tab per task, one buffer list
-- shared by all of them. Moving between them is built in already (`gt`, `gT`,
-- `{count}gt`), so only the commands without a default key get one here.
local function tabmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
end

tabmap("<leader>tn", ":tabnew<cr>", "New tab")
-- `tq` rather than `tc`, to match <leader>q for closing a window.
tabmap("<leader>tq", ":tabclose<cr>", "Close tab")
tabmap("<leader>to", ":tabonly<cr>", "Close every other tab")
-- Promote the current split to a tab of its own.
tabmap("<leader>tw", "<C-w>T", "Move window to a new tab")

-- Alt+number jumps straight to a tab. <Tab> would be the obvious key, but
-- outside kitty's keyboard protocol it is the same byte as <C-i>, so binding it
-- costs jumplist-forward everywhere else.
for i = 1, 9 do
    tabmap("<M-" .. i .. ">", i .. "gt", "Go to tab " .. i)
end
