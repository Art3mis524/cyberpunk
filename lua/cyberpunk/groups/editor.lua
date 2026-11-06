-- Built-in editor UI: text area, gutters, popups, statusline, diffs, search.
local util = require('cyberpunk.util')

return function(c, cfg)
    local bg = cfg.transparent and c.none or c.bg0 -- editor background
    local panel = cfg.transparent and c.none or c.bg1 -- folds and fold column
    local reverse = { fmt = 'reverse' }

    return {
        Normal = { fg = c.fg, bg = bg },
        Terminal = { fg = c.fg, bg = bg },
        EndOfBuffer = { fg = cfg.ending_tildes and c.grey or c.bg0, bg = bg },
        FoldColumn = { fg = c.fg, bg = panel },
        Folded = { fg = c.fg, bg = panel },
        SignColumn = { fg = c.fg, bg = bg },
        ToolbarLine = { fg = c.fg },
        Cursor = reverse,
        vCursor = reverse,
        iCursor = reverse,
        lCursor = reverse,
        CursorIM = reverse,
        CursorColumn = { bg = c.bg1 },
        CursorLine = { bg = c.bg1 },
        ColorColumn = { bg = c.bg1 },
        CursorLineNr = { fg = c.fg },
        LineNr = { fg = c.grey },
        Conceal = { fg = c.grey, bg = c.bg1 },

        -- Diffs
        Added = { fg = c.green },
        Removed = { fg = c.red },
        Changed = { fg = c.blue },
        DiffAdd = { bg = c.diff_add },
        DiffChange = { bg = c.diff_change },
        DiffDelete = { bg = c.diff_delete },
        DiffText = { bg = c.diff_text },
        DiffAdded = { fg = c.green },
        DiffChanged = { fg = c.blue },
        DiffRemoved = { fg = c.red },
        DiffDeleted = { fg = c.red },
        DiffFile = { fg = c.cyan },
        DiffIndexLine = { fg = c.grey },

        -- Git conflict markers (git-conflict.nvim)
        GitConflictCurrent = { bg = util.darken(c.green, 0.15, c.bg0) },
        GitConflictCurrentLabel = { bg = util.darken(c.green, 0.25, c.bg0), fmt = 'bold' },
        GitConflictIncoming = { bg = util.darken(c.blue, 0.15, c.bg0) },
        GitConflictIncomingLabel = { bg = util.darken(c.blue, 0.25, c.bg0), fmt = 'bold' },
        GitConflictAncestor = { bg = util.darken(c.purple, 0.15, c.bg0) },
        GitConflictAncestorLabel = { bg = util.darken(c.purple, 0.25, c.bg0), fmt = 'bold' },

        Directory = { fg = c.blue },
        ErrorMsg = { fg = c.red, fmt = 'bold' },
        WarningMsg = { fg = c.yellow, fmt = 'bold' },
        MoreMsg = { fg = c.blue, fmt = 'bold' },
        Question = { fg = c.yellow },

        -- Search and matching
        CurSearch = { fg = c.bg0, bg = c.orange },
        IncSearch = { fg = c.bg0, bg = c.orange },
        Search = { fg = c.bg0, bg = c.bg_yellow },
        Substitute = { fg = c.bg0, bg = c.green },
        MatchParen = { bg = c.bg3 },

        NonText = { fg = c.grey },
        Whitespace = { fg = c.grey },
        SpecialKey = { fg = c.grey },

        -- Popup menu and floats
        Pmenu = { fg = c.fg, bg = c.bg1 },
        PmenuSbar = { bg = c.bg1 },
        PmenuSel = { fg = c.bg0, bg = c.bg_blue },
        PmenuThumb = { bg = c.grey },
        WildMenu = { fg = c.bg0, bg = c.blue },
        FloatBorder = { fg = c.grey, bg = c.bg1 },
        NormalFloat = { fg = c.fg, bg = c.bg1 },

        SpellBad = { fmt = 'undercurl', sp = c.red },
        SpellCap = { fmt = 'undercurl', sp = c.yellow },
        SpellLocal = { fmt = 'undercurl', sp = c.blue },
        SpellRare = { fmt = 'undercurl', sp = c.purple },

        -- Status, tab and window bars
        StatusLine = { fg = c.fg, bg = c.bg2 },
        StatusLineTerm = { fg = c.fg, bg = c.bg2 },
        StatusLineNC = { fg = c.grey, bg = c.bg1 },
        StatusLineTermNC = { fg = c.grey, bg = c.bg1 },
        TabLine = { fg = c.fg, bg = c.bg1 },
        TabLineFill = { fg = c.grey, bg = c.bg1 },
        TabLineSel = { fg = c.bg0, bg = c.fg },
        WinSeparator = { fg = c.bg3 },
        WinBar = { fg = c.fg, bg = bg },
        WinBarNC = { fg = c.grey, bg = bg },

        Visual = { bg = c.bg3 },
        VisualNOS = { bg = c.bg2, fmt = 'underline' },
        QuickFixLine = { fg = c.blue, fmt = 'underline' },
        Debug = { fg = c.yellow },
        debugPC = { fg = c.bg0, bg = c.green },
        debugBreakpoint = { fg = c.bg0, bg = c.red },
        ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
    }
end
