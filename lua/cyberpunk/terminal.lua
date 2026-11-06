-- :terminal colours. The bright variants (8-15) reuse the normal ones, apart
-- from grey for bright black.
local M = {}

function M.apply(c)
    local ansi = { c.black, c.red, c.green, c.yellow, c.blue, c.purple, c.cyan, c.fg }
    for i, color in ipairs(ansi) do
        vim.g['terminal_color_' .. (i - 1)] = color
        vim.g['terminal_color_' .. (i + 7)] = color
    end
    vim.g.terminal_color_8 = c.grey
end

return M
