-- Headless tests for the colorscheme. Run from anywhere:
--
--     nvim --clean --headless -l tests/run.lua
--
-- Prints one line per test and exits non-zero if any fail.

local root = vim.fn.fnamemodify(arg[0], ':p:h:h')
vim.opt.rtp:prepend(root)

local failures = 0
local function test(name, fn)
    -- Fresh state for each test: forget options and loaded modules.
    for mod in pairs(package.loaded) do
        if mod:match('^cyberpunk') or mod:match('^lualine') then package.loaded[mod] = nil end
    end
    vim.cmd.highlight('clear')
    local ok, err = pcall(fn)
    if ok then
        io.stdout:write('  ok:   ' .. name .. '\n')
    else
        failures = failures + 1
        io.stdout:write('  FAIL: ' .. name .. '\n        ' .. tostring(err):gsub('\n', '\n        ') .. '\n')
    end
end

local function eq(actual, expected, what)
    if actual ~= expected then
        error(('%s: expected %s, got %s'):format(what, vim.inspect(expected), vim.inspect(actual)), 2)
    end
end

-- nvim_get_hl colours are integers; compare as lowercase '#rrggbb'.
local function hl(name)
    local h = vim.api.nvim_get_hl(0, { name = name, link = false })
    for _, key in ipairs({ 'fg', 'bg', 'sp' }) do
        if h[key] then h[key] = ('#%06x'):format(h[key]) end
    end
    return h
end

local palettes = dofile(root .. '/lua/cyberpunk/palette.lua')

test('dark and neon palettes have the same colours, all #rrggbb', function()
    local function keys(t)
        local list = vim.tbl_keys(t)
        table.sort(list)
        return table.concat(list, ' ')
    end
    eq(keys(palettes.neon), keys(palettes.dark), 'neon palette keys')
    for style, palette in pairs(palettes) do
        for name, color in pairs(palette) do
            assert(color:match('^#%x%x%x%x%x%x$'), ('%s.%s is not #rrggbb: %s'):format(style, name, color))
        end
    end
end)

test('every group module builds for both styles, with no group defined twice', function()
    local highlights = require('cyberpunk.highlights')
    for style in pairs(palettes) do
        local cyberpunk = require('cyberpunk')
        local seen = {}
        for _, module in ipairs(highlights.modules) do
            -- The palette errors on unknown colours, so a typo fails here.
            for name in pairs(require('cyberpunk.groups.' .. module)(cyberpunk.palette(style), cyberpunk.config)) do
                assert(not seen[name], ('%s is defined in both %s and %s'):format(name, seen[name], module))
                seen[name] = module
            end
        end
    end
end)

for style, scheme in pairs({ dark = 'cyberpunk', neon = 'cyberpunkNeon' }) do
    test(':colorscheme ' .. scheme .. ' applies the ' .. style .. ' palette', function()
        vim.cmd.colorscheme(scheme)
        local c = palettes[style]
        eq(vim.g.colors_name, scheme, 'g:colors_name')
        eq(vim.o.background, 'dark', 'background')
        eq(hl('Normal').bg, c.bg0, 'Normal bg')
        eq(hl('Normal').fg, c.fg, 'Normal fg')
        eq(hl('@function').fg, c.blue, '@function fg')
        eq(hl('@keyword').bold, true, '@keyword bold (default code_style)')
        eq(hl('Comment').italic, true, 'Comment italic')
        eq(hl('@lsp.type.parameter').fg, c.rose, 'semantic token link resolves')
        eq(vim.g.terminal_color_8, c.grey, 'terminal bright black')
    end)
end

test('every link points at a group that exists', function()
    vim.cmd.colorscheme('cyberpunk')
    local cyberpunk = require('cyberpunk')
    for name, spec in pairs(require('cyberpunk.highlights').groups(cyberpunk.palette(), cyberpunk.config)) do
        if spec.link then
            assert(next(vim.api.nvim_get_hl(0, { name = spec.link })), name .. ' links to missing ' .. spec.link)
        end
    end
end)

test('switching styles changes colours; toggle() cycles them', function()
    vim.cmd.colorscheme('cyberpunk')
    local dark_bg = hl('Normal').bg
    require('cyberpunk').toggle()
    eq(vim.g.colors_name, 'cyberpunkNeon', 'after toggle')
    assert(hl('Normal').bg ~= dark_bg, 'Normal bg did not change')
    require('cyberpunk').toggle()
    eq(vim.g.colors_name, 'cyberpunk', 'after second toggle')
end)

test('setup() options are kept by :colorscheme', function()
    require('cyberpunk').setup({
        code_style = { keywords = 'none', comments = 'bold,italic' },
        colors = { bg0 = '#000000' },
        transparent = false,
    })
    vim.cmd.colorscheme('cyberpunkNeon')
    eq(hl('@keyword').bold, nil, '@keyword bold')
    eq(hl('Comment').bold, true, 'Comment bold')
    eq(hl('Normal').bg, '#000000', 'Normal bg override')
end)

test('transparent leaves the background unset', function()
    require('cyberpunk').setup({ transparent = true })
    vim.cmd.colorscheme('cyberpunk')
    eq(hl('Normal').bg, nil, 'Normal bg')
end)

test('highlight overrides replace only the given fields and resolve $colours', function()
    require('cyberpunk').setup({
        highlights = {
            Comment = { fg = '$red' }, -- keeps italic
            ['@lsp.type.comment'] = { fg = '$cyan' }, -- overriding a link
            MyGroup = { fg = '#123456', fmt = 'underline' }, -- a new group
        },
    })
    vim.cmd.colorscheme('cyberpunk')
    eq(hl('Comment').fg, palettes.dark.red, 'Comment fg')
    eq(hl('Comment').italic, true, 'Comment keeps italic')
    eq(hl('@lsp.type.comment').fg, palettes.dark.cyan, '@lsp.type.comment fg')
    eq(hl('MyGroup').underline, true, 'MyGroup underline')
end)

test('a bad override is reported, not fatal', function()
    local messages = {}
    local notify = vim.notify
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(msg) table.insert(messages, msg) end
    require('cyberpunk').setup({ highlights = { Comment = { fg = '$nope' } } })
    local ok, err = pcall(vim.cmd.colorscheme, 'cyberpunk')
    vim.notify = notify
    assert(ok, err)
    assert(#messages == 1 and messages[1]:find('nope'), 'expected one notification, got ' .. vim.inspect(messages))
    eq(hl('Normal').bg, palettes.dark.bg0, 'rest of the theme applied')
end)

test('an unknown style errors without touching the current colours', function()
    vim.cmd.colorscheme('cyberpunkNeon')
    local ok = pcall(require('cyberpunk').load, 'light')
    assert(not ok, 'load("light") should fail')
    eq(vim.g.colors_name, 'cyberpunkNeon', 'colors_name unchanged')
    eq(hl('Normal').bg, palettes.neon.bg0, 'Normal unchanged')
end)

test('lualine theme follows the active style', function()
    for style, scheme in pairs({ dark = 'cyberpunk', neon = 'cyberpunkNeon' }) do
        vim.cmd.colorscheme(scheme)
        local theme = dofile(root .. '/lua/lualine/themes/cyberpunk.lua')
        eq(theme.normal.a.bg, palettes[style].green, style .. ' normal.a bg')
        eq(theme.insert.a.bg, palettes[style].blue, style .. ' insert.a bg')
        eq(theme.normal.c.bg, palettes[style].bg1, style .. ' normal.c bg')
    end
end)

io.stdout:write('\n' .. (failures == 0 and 'ALL TESTS PASSED' or ('FAILED: ' .. failures .. ' test(s)')) .. '\n')
os.exit(failures == 0 and 0 or 1)
