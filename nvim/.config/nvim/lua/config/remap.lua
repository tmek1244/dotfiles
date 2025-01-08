-- LunarVim config
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-s>", ":w<cr>", opts)
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", opts)

vim.keymap.set("n", "<C-h>", ":KittyNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", ":KittyNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-k>", ":KittyNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-l>", ":KittyNavigateRight<CR>", opts)

vim.keymap.set("n", "<leader>q", ":q<cr>", opts)
vim.keymap.set("n", "<Esc>", ":nohlsearch<cr>", opts)
vim.keymap.set("n", "<leader>lw", "/<C-R><C-W><cr>``", opts)
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
