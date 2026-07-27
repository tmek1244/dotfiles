-- Nvim's indent/python.vim adds `:` to 'indentkeys', so that typing the colon of
-- `else:`/`except:` re-runs 'indentexpr' and dedents the line. Under the
-- treesitter indent expression (see plugins/treesitter.lua) that dedent does not
-- happen at all, so the trigger only ever does harm: while a docstring is still
-- open tree-sitter cannot build a string node for it and parses the contents as
-- code in the enclosing block, so typing `Args:` shifts the line a level right.
--
-- This has to live in after/indent rather than after/ftplugin: `filetype plugin`
-- is registered before `filetype indent`, so indent/python.vim would re-add the
-- keys after an ftplugin removed them.
vim.opt_local.indentkeys:remove(":")
vim.opt_local.indentkeys:remove("<:>")
