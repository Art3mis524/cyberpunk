-- lualine theme for both styles: lualine re-reads this file on every
-- :colorscheme, so it follows whichever style is active.
local cyberpunk = require('cyberpunk')
local c = cyberpunk.palette()
local middle = cyberpunk.config.lualine.transparent and c.none or c.bg1

local function mode(color)
    return { a = { fg = c.bg0, bg = color, gui = 'bold' } }
end

local theme = {
    normal = {
        a = { fg = c.bg0, bg = c.green, gui = 'bold' },
        b = { fg = c.fg, bg = c.bg3 },
        c = { fg = c.fg, bg = middle },
    },
    inactive = {
        a = { fg = c.grey, bg = c.bg1, gui = 'bold' },
        b = { fg = c.grey, bg = c.bg1 },
        c = { fg = c.grey, bg = middle },
    },
    insert = mode(c.blue),
    visual = mode(c.purple),
    replace = mode(c.red),
    command = mode(c.yellow),
    terminal = mode(c.cyan),
}

return theme
