local M = {}

local function rgb(hex)
    local r, g, b = hex:lower():match('^#(%x%x)(%x%x)(%x%x)$')
    assert(r, 'cyberpunk: invalid hex colour: ' .. tostring(hex))
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

--- Mixes two colours: alpha 1 gives `fg`, 0 gives `bg`.
---@param fg string '#rrggbb'
---@param bg string '#rrggbb'
---@param alpha number 0..1
function M.blend(fg, bg, alpha)
    local f, b = rgb(fg), rgb(bg)
    local function channel(i)
        local v = alpha * f[i] + (1 - alpha) * b[i]
        return math.floor(math.min(math.max(0, v), 255) + 0.5)
    end
    return ('#%02X%02X%02X'):format(channel(1), channel(2), channel(3))
end

--- `hex` faded towards `bg` (black by default); amount 1 leaves it unchanged.
function M.darken(hex, amount, bg)
    return M.blend(hex, bg or '#000000', math.abs(amount))
end

local ATTRIBUTES = {
    bold = true, italic = true, reverse = true, standout = true, nocombine = true,
    strikethrough = true, underline = true, undercurl = true,
    underdouble = true, underdotted = true, underdashed = true,
}

--- Turns an onedark-style `fmt` string ("bold,italic", "none") into the
--- boolean flags nvim_set_hl expects, adding them to `into`.
---@param fmt string|false|nil
---@param into table|nil
function M.attributes(fmt, into)
    into = into or {}
    if type(fmt) ~= 'string' then return into end
    for attr in fmt:lower():gmatch('[^,%s]+') do
        if ATTRIBUTES[attr] then
            into[attr] = true
        elseif attr ~= 'none' then
            error(('cyberpunk: unknown text attribute %q'):format(attr), 2)
        end
    end
    return into
end

return M
