local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local M = {}

-- The fields after the two spaces filter by path, and are meant to be typed as
-- fragments rather than full paths:
--
--   test  config            content `test`, in/under anything named *config*
--   test  .config/  *.json  the two fields compose: *.json under *.config*
--   test  config  !spec     `!` subtracts
--   test  /.config/         a leading `/` anchors to the search root
--
-- Bare words match "contains"; anything with glob syntax (`*.json`, `[abc]`) is
-- used as written.
local METACHARS = "[%*%?%[%]{}]"

-- Split one field into path segments, wrapping bare words so they match
-- loosely. Also reports whether the field named a directory (trailing slash)
-- and whether its final segment was a bare word.
local function expand(text)
  local dir_mode = text:match("/+$") ~= nil
  text = text:gsub("/+$", "")

  local segs, last_bare = {}, false
  for _, seg in ipairs(vim.split(text, "/")) do
    if seg ~= "" then
      local bare = not seg:find(METACHARS)
      table.insert(segs, bare and ("*" .. seg .. "*") or seg)
      last_bare = bare
    end
  end
  return segs, dir_mode, last_bare
end

-- Join fields into a single glob. `**/` between every segment is what lets a
-- fragment match at any depth, so the path never has to be spelled out from the
-- root. Composing into one glob (rather than one `-g` per field) is what makes
-- extra fields narrow the search instead of widening it -- ripgrep ORs separate
-- include globs together.
local function build_globs(fields)
  local anchored, segs, dir_mode, last_bare = false, {}, false, false

  for i, field in ipairs(fields) do
    if i == 1 and field:sub(1, 1) == "/" then
      anchored = true
      field = field:sub(2)
    end
    local s, dm, lb = expand(field)
    vim.list_extend(segs, s)
    dir_mode, last_bare = dm, lb
  end

  if #segs == 0 then
    return {}
  end

  local glob = (anchored and "" or "**/") .. table.concat(segs, "/**/")

  if dir_mode then
    return { glob .. "/**" }
  end
  if last_bare then
    -- A bare word could name either a file or a directory, so match both.
    return { glob, glob .. "/**" }
  end
  return { glob }
end

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      -- Positive fields compose into one glob; each `!field` subtracts on its own.
      local positives, negatives = {}, {}
      for i = 2, #pieces do
        local field = pieces[i]
        if field ~= "" then
          if field:sub(1, 1) == "!" then
            table.insert(negatives, field:sub(2))
          else
            table.insert(positives, field)
          end
        end
      end

      for _, glob in ipairs(build_globs(positives)) do
        table.insert(args, "-g")
        table.insert(args, glob)
      end

      for _, field in ipairs(negatives) do
        for _, glob in ipairs(build_globs({ field })) do
          table.insert(args, "-g")
          table.insert(args, "!" .. glob)
        end
      end

      return vim.list_extend(args, {
        "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
        "--smart-case", "--glob-case-insensitive", "--hidden",
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

-- Exposed so the keymap can live in the telescope lazy spec.
M.live_multigrep = live_multigrep

return M