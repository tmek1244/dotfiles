return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = 'v0.*',

        opts = {
            keymap = {
                preset = 'super-tab',
                ['<Tab>'] = {},
                ['<Enter>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
            },
            cmdline = {
                keymap = { preset = 'enter' },
                completion = {
                    menu = { auto_show = true },
                    list = { selection = { preselect = false } },
                },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                accept = { auto_brackets = { enabled = true }, },
            },
            signature = { enabled = true }
        },
    },
}
