local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.keymap.set("n", "<leader>gd", function() vim.diagnostic.open_float() end, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    require("lsp_signature").on_attach({
        toggle_key = '<A-l>',
        hint_enable = false,
    }, event.buf)
  end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'html',
    'pyright',
    'pylsp',
    'gopls'
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})



--
-- local lsp_zero = require('lsp-zero')
--
--
-- lsp_zero.on_attach(function(client, bufnr)
--   local opts = {buffer = bufnr, remap = false}
--
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
--   vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
--   vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
--   vim.keymap.set("n", "<f2>", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("n", "<f3>", function() vim.lsp.buf.format() end, opts)
--
--   --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--   --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--   --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--   --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--   --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--   --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = {
--     'ts_ls',
--     'eslint',
--     'html',
--     'pyright',
--     'pylsp',
--     'gopls'
--   },
--   handlers = {
--     lsp_zero.default_setup,
--     lua_ls = function()
--       local lua_opts = lsp_zero.nvim_lua_ls()
--       require('lspconfig').lua_ls.setup(lua_opts)
--       require('lspconfig').pyright.setup{}
--     end,
--   }
-- })
--
-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
--
-- cmp.setup({
--   sources = {
--     {name = 'path'},
--     {name = 'nvim_lsp'},
--     {name = 'nvim_lua'},
--     {name = 'luasnip', keyword_length = 2},
--     {name = 'buffer', keyword_length = 3},
--   },
--   formatting = lsp_zero.cmp_format(),
--   mapping = cmp.mapping.preset.insert({
--     ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<C-e>'] = cmp.mapping.abort(),
--     -- ['<C-Space>'] = cmp.mapping.complete(),
--   }),
-- })
