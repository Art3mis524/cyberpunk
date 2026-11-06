local M = {}

--- The :colorscheme name for each style.
M.colorschemes = { dark = 'cyberpunk', neon = 'cyberpunkNeon' }

local defaults = {
    style = 'dark', -- 'dark' or 'neon'; the :colorscheme commands set this
    toggle_style_key = nil, -- e.g. '<leader>ts' to cycle through toggle_style_list
    toggle_style_list = { 'dark', 'neon' },
    transparent = false, -- leave the editor background unset
    term_colors = true, -- colour :terminal buffers from the palette
    ending_tildes = false, -- show ~ on the lines after the end of a buffer
    cmp_itemkind_reverse = false, -- nvim-cmp item kinds as reversed blocks

    -- Text attributes per syntax role: 'none' or comma-separated
    -- 'bold', 'italic', 'underline', 'undercurl', 'strikethrough', ...
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'none',
        strings = 'none',
        variables = 'none',
        constants = 'none',
    },

    lualine = {
        transparent = false, -- no background behind lualine's middle (c) section
    },

    colors = {}, -- palette overrides: { bg0 = '#000000' }
    -- Highlight group overrides. Only the fields given are replaced, and
    -- '$name' refers to a palette colour: { Comment = { fg = '$cyan', fmt = 'none' } }
    highlights = {},

    diagnostics = {
        darker = true, -- muted colours for diagnostic virtual text
        undercurl = true, -- undercurl rather than underline diagnostics
        background = true, -- tinted background behind virtual text
    },
}

M.config = vim.deepcopy(defaults)

--- Sets options without applying the theme (`:colorscheme` does that).
---@param opts table|nil see `defaults` above
function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend('force', M.config, opts)
    -- Lists would be merged index by index; take the user's list as given.
    if opts.toggle_style_list then
        M.config.toggle_style_list = opts.toggle_style_list
    end
    if M.config.toggle_style_key then
        vim.keymap.set('n', M.config.toggle_style_key, M.toggle, { desc = 'Cycle cyberpunk styles' })
    end
end

--- The palette for `style` (default: the current one) with the `colors`
--- overrides applied. Reading a colour that doesn't exist is an error, so a
--- typo in a highlight definition fails loudly instead of silently
--- dropping that colour.
---@param style string|nil
function M.palette(style)
    style = style or M.config.style
    local base = require('cyberpunk.palette')[style]
    if not base then
        error(('cyberpunk: unknown style %q (expected "dark" or "neon")'):format(tostring(style)), 2)
    end
    local colors = vim.tbl_extend('force', { none = 'none' }, base, M.config.colors)
    return setmetatable(colors, {
        __index = function(_, name)
            error(('cyberpunk: unknown colour %q'):format(tostring(name)), 2)
        end,
    })
end

--- Applies the theme in `style` (default: the current one). colors/*.lua
--- call this, so prefer `:colorscheme cyberpunk` / `:colorscheme cyberpunkNeon`.
---@param style string|nil
function M.load(style)
    if vim.fn.has('nvim-0.10') == 0 then
        vim.notify('cyberpunk needs Neovim 0.10 or newer', vim.log.levels.ERROR)
        return
    end
    -- Resolve the palette first, so a bad style leaves the current colours alone.
    local colors = M.palette(style)
    M.config.style = style or M.config.style

    vim.cmd.highlight('clear') -- also unsets g:colors_name
    if vim.fn.exists('syntax_on') == 1 then
        vim.cmd.syntax('reset')
    end
    vim.o.background = 'dark' -- both styles are dark
    vim.o.termguicolors = true
    vim.g.colors_name = M.colorschemes[M.config.style]

    require('cyberpunk.highlights').apply(colors, M.config)
    if M.config.term_colors then
        require('cyberpunk.terminal').apply(colors)
    end
end

--- Switches to the next style in `toggle_style_list`.
function M.toggle()
    local list, current = M.config.toggle_style_list, 0
    for i, style in ipairs(list) do
        if style == M.config.style then
            current = i
        end
    end
    vim.cmd.colorscheme(M.colorschemes[list[current % #list + 1]])
end

return M
