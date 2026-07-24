-- Locating a project's own Python tooling.
--
-- mypy and flake8 only say anything useful when run with the project's
-- dependencies and config, so a Mason-installed copy (its own isolated venv) is
-- worse than nothing: it flags every third-party import as missing and ignores
-- the project's plugins and rule selection. Only a copy in the project's
-- virtualenv counts.
--
-- Both plugins/lint.lua and the ruff/pyright overrides in plugins/lsp.lua key
-- off this: a project whose virtualenv ships mypy/flake8 is linted by them,
-- every other project keeps the default ruff + pyright setup untouched.
local M = {}

local venv_dirs = { '.venv', 'venv' }

--- Path to `name` inside the project's virtualenv, or nil when the project does
--- not ship it. `$VIRTUAL_ENV` is checked last so an unrelated activated shell
--- venv cannot stand in for what the project itself declares.
--- @param name string executable to look for, e.g. 'mypy'
--- @param root string|nil project root; defaults to the current buffer's
--- @return string|nil
function M.tool(name, root)
    root = root or vim.fs.root(0, venv_dirs)

    local candidates = {}
    if root then
        for _, dir in ipairs(venv_dirs) do
            table.insert(candidates, root .. '/' .. dir .. '/bin/' .. name)
        end
    end
    local venv = os.getenv('VIRTUAL_ENV')
    if venv then
        table.insert(candidates, venv .. '/bin/' .. name)
    end

    for _, exe in ipairs(candidates) do
        if vim.fn.executable(exe) == 1 then
            return exe
        end
    end
    return nil
end

return M
