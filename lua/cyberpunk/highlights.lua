-- Collects the highlight groups from groups/*.lua and applies them.
--
-- A group spec is either { fg, bg, sp, fmt } with colours as '#rrggbb' and
-- fmt as an onedark-style attribute string ('bold,italic', 'none'), or
-- { link = 'OtherGroup' }.
local util = require('cyberpunk.util')

local M = {}

--- Group modules, each `function(colors, config) -> { [group] = spec }`.
M.modules = { 'editor', 'syntax', 'treesitter', 'lsp', 'languages', 'plugins' }

--- Every group the theme defines, keyed by name.
function M.groups(c, cfg)
    local groups = {}
    for _, module in ipairs(M.modules) do
        for name, spec in pairs(require('cyberpunk.groups.' .. module)(c, cfg)) do
            groups[name] = spec
        end
    end
    return groups
end

-- Converts a spec to nvim_set_hl's format. 'NONE' colours are left unset.
local function to_hl(spec)
    if spec.link then
        return { link = spec.link }
    end
    local hl = util.attributes(spec.fmt)
    for _, key in ipairs({ 'fg', 'bg', 'sp' }) do
        local color = spec[key]
        if color and color:upper() ~= 'NONE' then
            hl[key] = color
        end
    end
    return hl
end

-- Resolves '$name' palette references in a user override.
local function resolve(override, c)
    local spec = {}
    for key, value in pairs(override) do
        if type(value) == 'string' and value:sub(1, 1) == '$' then
            value = c[value:sub(2)]
        end
        spec[key] = value
    end
    return spec
end

function M.apply(c, cfg)
    local groups = M.groups(c, cfg)
    for name, spec in pairs(groups) do
        vim.api.nvim_set_hl(0, name, to_hl(spec))
    end

    -- User overrides replace only the fields they set. Overriding a linked
    -- group starts from scratch, since a link has no fields to keep.
    for name, override in pairs(cfg.highlights) do
        local ok, err = pcall(function()
            local base = groups[name] or {}
            if base.link and not override.link then
                base = {}
            end
            vim.api.nvim_set_hl(0, name, to_hl(vim.tbl_extend('force', base, resolve(override, c))))
        end)
        if not ok then
            vim.notify(('cyberpunk: highlights.%s: %s'):format(name, err), vim.log.levels.ERROR)
        end
    end
end

return M
