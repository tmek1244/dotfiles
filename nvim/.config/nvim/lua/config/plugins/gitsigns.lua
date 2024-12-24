return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                  add          = { text = '│' },
                  change       = { text = '│' },
                  delete       = { text = '󰐊' },
                  topdelete    = { text = '󰐊' },
                  changedelete = { text = '~' },
                  untracked    = { text = '┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                  follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                  virt_text = true,
                  virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                  delay = 1000,
                  ignore_whitespace = false,
                  virt_text_priority = 100,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                  -- Options passed to nvim_open_win
                  border = 'single',
                  style = 'minimal',
                  relative = 'cursor',
                  row = 0,
                  col = 1
                },
                yadm = {
                  enable = false
                },
                on_attach = function(bufnr)
                  local gs = package.loaded.gitsigns
              
                  local function map(mode, l, r, opts)
                      opts = opts or { noremap = true, silent = true }
                      opts.buffer = bufnr
                      vim.keymap.set(mode, l, r, opts)
                  end
              
                  map('n', '<leader>hn', gs.next_hunk)
                  map('n', '<leader>hN', gs.prev_hunk)
                  map('n', '<leader>hh', gs.preview_hunk)
                  map('n', '<leader>hr', gs.reset_hunk)
                  map('n', '<leader>hR', gs.reset_buffer)
                  map('n', '<leader>hd', gs.diffthis)
                end
            }
        end
    }
}
