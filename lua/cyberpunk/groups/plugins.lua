-- Plugin integrations, alphabetical by plugin. Groups for plugins that
-- aren't installed are harmless.
local util = require('cyberpunk.util')

-- Colour of each LSP completion/symbol kind, shared by every plugin that
-- shows kinds (cmp, blink, aerial, navic, dropbar).
local function kind_colors(c)
    return {
        Default = c.purple, Array = c.yellow, Boolean = c.orange, Class = c.yellow,
        Color = c.green, Constant = c.orange, Constructor = c.blue, Enum = c.purple,
        EnumMember = c.yellow, Event = c.yellow, Field = c.purple, File = c.blue,
        Folder = c.orange, Function = c.blue, Interface = c.green, Key = c.cyan,
        Keyword = c.cyan, Method = c.blue, Module = c.orange, Namespace = c.red,
        Null = c.grey, Number = c.orange, Object = c.red, Operator = c.red,
        Package = c.yellow, Property = c.cyan, Reference = c.orange, Snippet = c.red,
        String = c.green, Struct = c.purple, Text = c.light_grey, TypeParameter = c.red,
        Unit = c.green, Value = c.orange, Variable = c.purple,
    }
end

return function(c, cfg)
    local tree_bg = cfg.transparent and c.none or c.bg_d -- file tree sidebars
    local fg, grey, light_grey = { fg = c.fg }, { fg = c.grey }, { fg = c.light_grey }
    local red, green, blue = { fg = c.red }, { fg = c.green }, { fg = c.blue }
    local cyan, yellow, orange, purple = { fg = c.cyan }, { fg = c.yellow }, { fg = c.orange }, { fg = c.purple }
    local nocombine_bg1 = { fg = c.bg1, fmt = 'nocombine' }
    local selected_bold = { bg = c.bg2, fmt = 'bold' }
    local cmp_kind_fmt = cfg.cmp_itemkind_reverse and 'reverse' or nil

    local groups = {
        -- ale
        ALEErrorSign = { link = 'DiagnosticError' },
        ALEInfoSign = { link = 'DiagnosticInfo' },
        ALEWarningSign = { link = 'DiagnosticWarn' },

        -- barbar.nvim
        BufferCurrent = { fmt = 'bold' },
        BufferCurrentMod = { fg = c.orange, fmt = 'bold,italic' },
        BufferCurrentSign = purple,
        BufferInactiveMod = { fg = c.light_grey, bg = c.bg1, fmt = 'italic' },
        BufferVisible = { fg = c.light_grey, bg = c.bg0 },
        BufferVisibleMod = { fg = c.yellow, bg = c.bg0, fmt = 'italic' },
        BufferVisibleIndex = { fg = c.light_grey, bg = c.bg0 },
        BufferVisibleSign = { fg = c.light_grey, bg = c.bg0 },
        BufferVisibleTarget = { fg = c.light_grey, bg = c.bg0 },

        -- blink.cmp
        BlinkCmpLabel = fg,
        BlinkCmpLabelDeprecated = { fg = c.light_grey, fmt = 'strikethrough' },
        BlinkCmpLabelMatch = cyan,
        BlinkCmpDetail = light_grey,
        BlinkCmpKind = purple,

        -- nvim-cmp
        CmpItemAbbr = fg,
        CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = 'strikethrough' },
        CmpItemAbbrMatch = cyan,
        CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = 'underline' },
        CmpItemMenu = light_grey,
        CmpItemKind = { fg = c.purple, fmt = cmp_kind_fmt },

        -- coc.nvim
        CocErrorSign = { link = 'DiagnosticError' },
        CocHintSign = { link = 'DiagnosticHint' },
        CocInfoSign = { link = 'DiagnosticInfo' },
        CocWarningSign = { link = 'DiagnosticWarn' },

        -- dashboard-nvim
        DashboardShortCut = blue,
        DashboardHeader = yellow,
        DashboardCenter = cyan,
        DashboardFooter = { fg = c.dark_red, fmt = 'italic' },

        -- diffview.nvim
        DiffviewFilePanelTitle = { fg = c.blue, fmt = 'bold' },
        DiffviewFilePanelCounter = { fg = c.purple, fmt = 'bold' },
        DiffviewFilePanelFileName = fg,
        DiffviewNormal = { link = 'Normal' },
        DiffviewCursorLine = { link = 'CursorLine' },
        DiffviewVertSplit = { link = 'WinSeparator' },
        DiffviewSignColumn = { link = 'SignColumn' },
        DiffviewStatusLine = { link = 'StatusLine' },
        DiffviewStatusLineNC = { link = 'StatusLineNC' },
        DiffviewEndOfBuffer = { link = 'EndOfBuffer' },
        DiffviewFilePanelRootPath = grey,
        DiffviewFilePanelPath = grey,
        DiffviewFilePanelInsertions = green,
        DiffviewFilePanelDeletions = red,
        DiffviewStatusAdded = green,
        DiffviewStatusUntracked = blue,
        DiffviewStatusModified = blue,
        DiffviewStatusRenamed = blue,
        DiffviewStatusCopied = blue,
        DiffviewStatusTypeChange = blue,
        DiffviewStatusUnmerged = blue,
        DiffviewStatusUnknown = red,
        DiffviewStatusDeleted = red,
        DiffviewStatusBroken = red,

        -- dropbar.nvim
        DropBarIconKind = yellow,
        DropBarKind = fg,
        DropBarMenuHoverIcon = { fmt = 'reverse' },
        DropBarWinBar = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
        DropBarSeparator = grey,

        -- vim-gitgutter
        GitGutterAdd = green,
        GitGutterChange = blue,
        GitGutterDelete = red,

        -- gitsigns.nvim
        GitSignsAdd = green,
        GitSignsAddLn = green,
        GitSignsAddNr = green,
        GitSignsChange = blue,
        GitSignsChangeLn = blue,
        GitSignsChangeNr = blue,
        GitSignsDelete = red,
        GitSignsDeleteLn = red,
        GitSignsDeleteNr = red,

        -- hop.nvim
        HopNextKey = { fg = c.red, fmt = 'bold' },
        HopNextKey1 = { fg = c.cyan, fmt = 'bold' },
        HopNextKey2 = { fg = util.darken(c.blue, 0.7) },
        HopUnmatched = grey,

        -- vim-illuminate
        illuminatedWord = selected_bold,
        illuminatedCurWord = selected_bold,
        IlluminatedWordText = selected_bold,
        IlluminatedWordRead = selected_bold,
        IlluminatedWordWrite = selected_bold,

        -- indent-blankline.nvim (v2 names, then v3 "ibl" names and its rainbow scope)
        IndentBlanklineIndent1 = blue,
        IndentBlanklineIndent2 = green,
        IndentBlanklineIndent3 = cyan,
        IndentBlanklineIndent4 = light_grey,
        IndentBlanklineIndent5 = purple,
        IndentBlanklineIndent6 = red,
        IndentBlanklineChar = nocombine_bg1,
        IndentBlanklineContextChar = { fg = c.grey, fmt = 'nocombine' },
        IndentBlanklineContextStart = { sp = c.grey, fmt = 'underline' },
        IndentBlanklineContextSpaceChar = { fmt = 'nocombine' },
        IblIndent = nocombine_bg1,
        IblWhitespace = nocombine_bg1,
        IblScope = { fg = c.purple, fmt = 'nocombine' },
        RainbowRed = red,
        RainbowYellow = yellow,
        RainbowBlue = blue,
        RainbowOrange = orange,
        RainbowGreen = green,
        RainbowViolet = purple,
        RainbowCyan = cyan,

        -- indentmini.nvim
        IndentLine = { fg = c.bg2 },
        IndentLineCurrent = grey,

        -- mini.nvim
        MiniAnimateCursor = { fmt = 'reverse,nocombine' },
        MiniAnimateNormalFloat = { link = 'NormalFloat' },
        MiniClueBorder = { link = 'FloatBorder' },
        MiniClueDescGroup = { link = 'DiagnosticWarn' },
        MiniClueDescSingle = { link = 'NormalFloat' },
        MiniClueNextKey = { link = 'DiagnosticHint' },
        MiniClueNextKeyWithPostkeys = { link = 'DiagnosticError' },
        MiniClueSeparator = { link = 'DiagnosticInfo' },
        MiniClueTitle = cyan,
        MiniCompletionActiveParameter = { fmt = 'underline' },
        MiniCursorword = { fmt = 'underline' },
        MiniCursorwordCurrent = { fmt = 'underline' },
        MiniDepsChangeAdded = { link = 'Added' },
        MiniDepsChangeRemoved = { link = 'Removed' },
        MiniDepsHint = { link = 'DiagnosticHint' },
        MiniDepsInfo = { link = 'DiagnosticInfo' },
        MiniDepsMsgBreaking = { link = 'DiagnosticWarn' },
        MiniDepsPlaceholder = { link = 'Comment' },
        MiniDepsTitle = { link = 'Title' },
        MiniDepsTitleError = { link = 'DiffDelete' },
        MiniDepsTitleSame = { link = 'DiffText' },
        MiniDepsTitleUpdate = { link = 'DiffAdd' },
        MiniDiffSignAdd = green,
        MiniDiffSignChange = blue,
        MiniDiffSignDelete = red,
        MiniDiffOverAdd = { link = 'DiffAdd' },
        MiniDiffOverChange = { link = 'DiffText' },
        MiniDiffOverContext = { link = 'DiffChange' },
        MiniDiffOverDelete = { link = 'DiffDelete' },
        MiniFilesBorder = { link = 'FloatBorder' },
        MiniFilesBorderModified = { link = 'DiagnosticWarn' },
        MiniFilesCursorLine = { bg = c.bg2 },
        MiniFilesDirectory = { link = 'Directory' },
        MiniFilesFile = fg,
        MiniFilesNormal = { link = 'NormalFloat' },
        MiniFilesTitle = cyan,
        MiniFilesTitleFocused = { fg = c.cyan, fmt = 'bold' },
        MiniHipatternsFixme = { fg = c.bg0, bg = c.red, fmt = 'bold' },
        MiniHipatternsHack = { fg = c.bg0, bg = c.yellow, fmt = 'bold' },
        MiniHipatternsNote = { fg = c.bg0, bg = c.cyan, fmt = 'bold' },
        MiniHipatternsTodo = { fg = c.bg0, bg = c.purple, fmt = 'bold' },
        MiniIconsAzure = { fg = c.bg_blue },
        MiniIconsBlue = blue,
        MiniIconsCyan = cyan,
        MiniIconsGreen = green,
        MiniIconsGrey = fg,
        MiniIconsOrange = orange,
        MiniIconsPurple = purple,
        MiniIconsRed = red,
        MiniIconsYellow = yellow,
        MiniIndentscopeSymbol = grey,
        MiniIndentscopePrefix = { fmt = 'nocombine' }, -- invisible
        MiniJump = { fg = c.purple, fmt = 'underline', sp = c.purple },
        MiniJump2dDim = { fg = c.grey, fmt = 'nocombine' },
        MiniJump2dSpot = { fg = c.red, fmt = 'bold,nocombine' },
        MiniJump2dSpotAhead = { fg = c.cyan, bg = c.bg0, fmt = 'nocombine' },
        MiniJump2dSpotUnique = { fg = c.yellow, fmt = 'bold,nocombine' },
        MiniMapNormal = { link = 'NormalFloat' },
        MiniMapSymbolCount = { link = 'Special' },
        MiniMapSymbolLine = { link = 'Title' },
        MiniMapSymbolView = { link = 'Delimiter' },
        MiniNotifyBorder = { link = 'FloatBorder' },
        MiniNotifyNormal = { link = 'NormalFloat' },
        MiniNotifyTitle = cyan,
        MiniOperatorsExchangeFrom = { link = 'IncSearch' },
        MiniPickBorder = { link = 'FloatBorder' },
        MiniPickBorderBusy = { link = 'DiagnosticWarn' },
        MiniPickBorderText = { fg = c.cyan, fmt = 'bold' },
        MiniPickIconDirectory = { link = 'Directory' },
        MiniPickIconFile = { link = 'NormalFloat' },
        MiniPickHeader = { link = 'DiagnosticHint' },
        MiniPickMatchCurrent = { bg = c.bg2 },
        MiniPickMatchMarked = { bg = c.diff_text },
        MiniPickMatchRanges = { link = 'DiagnosticHint' },
        MiniPickNormal = { link = 'NormalFloat' },
        MiniPickPreviewLine = { bg = c.bg2 },
        MiniPickPreviewRegion = { link = 'IncSearch' },
        MiniPickPrompt = { link = 'DiagnosticInfo' },
        MiniStarterCurrent = { fmt = 'nocombine' },
        MiniStarterFooter = { fg = c.dark_red, fmt = 'italic' },
        MiniStarterHeader = yellow,
        MiniStarterInactive = { fg = c.grey, fmt = cfg.code_style.comments },
        MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
        MiniStarterItemBullet = grey,
        MiniStarterItemPrefix = yellow,
        MiniStarterSection = light_grey,
        MiniStarterQuery = cyan,
        MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg2 },
        MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg2 },
        MiniStatuslineFilename = { fg = c.grey, bg = c.bg1 },
        MiniStatuslineInactive = { link = 'StatusLineNC' },
        MiniStatuslineModeCommand = { fg = c.bg0, bg = c.yellow, fmt = 'bold' },
        MiniStatuslineModeInsert = { fg = c.bg0, bg = c.blue, fmt = 'bold' },
        MiniStatuslineModeNormal = { fg = c.bg0, bg = c.green, fmt = 'bold' },
        MiniStatuslineModeOther = { fg = c.bg0, bg = c.cyan, fmt = 'bold' },
        MiniStatuslineModeReplace = { fg = c.bg0, bg = c.red, fmt = 'bold' },
        MiniStatuslineModeVisual = { fg = c.bg0, bg = c.purple, fmt = 'bold' },
        MiniSurround = { fg = c.bg0, bg = c.orange },
        MiniTablineCurrent = { fmt = 'bold' },
        MiniTablineFill = { fg = c.grey, bg = c.bg1 },
        MiniTablineHidden = { fg = c.fg, bg = c.bg1 },
        MiniTablineModifiedCurrent = { fg = c.orange, fmt = 'bold,italic' },
        MiniTablineModifiedHidden = { fg = c.light_grey, bg = c.bg1, fmt = 'italic' },
        MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg0, fmt = 'italic' },
        MiniTablineTabpagesection = { fg = c.bg0, bg = c.bg_yellow },
        MiniTablineVisible = { fg = c.light_grey, bg = c.bg0 },
        MiniTestEmphasis = { fmt = 'bold' },
        MiniTestFail = { fg = c.red, fmt = 'bold' },
        MiniTestPass = { fg = c.green, fmt = 'bold' },
        MiniTrailspace = { bg = c.red },

        -- nvim-navic
        NavicText = fg,
        NavicSeparator = light_grey,

        -- neo-tree.nvim
        NeoTreeNormal = { fg = c.fg, bg = tree_bg },
        NeoTreeNormalNC = { fg = c.fg, bg = tree_bg },
        NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
        NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
        NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = tree_bg },
        NeoTreeRootName = { fg = c.orange, fmt = 'bold' },
        NeoTreeGitAdded = green,
        NeoTreeGitDeleted = red,
        NeoTreeGitModified = yellow,
        NeoTreeGitConflict = { fg = c.red, fmt = 'bold,italic' },
        NeoTreeGitUntracked = { fg = c.red, fmt = 'italic' },
        NeoTreeIndentMarker = grey,
        NeoTreeSymbolicLinkTarget = purple,

        -- neotest
        NeotestAdapterName = { fg = c.purple, fmt = 'bold' },
        NeotestDir = cyan,
        NeotestExpandMarker = grey,
        NeotestFailed = red,
        NeotestFile = cyan,
        NeotestFocused = { fmt = 'bold,italic' },
        NeotestIndent = grey,
        NeotestMarked = { fg = c.orange, fmt = 'bold' },
        NeotestNamespace = blue,
        NeotestPassed = green,
        NeotestRunning = yellow,
        NeotestWinSelect = { fg = c.cyan, fmt = 'bold' },
        NeotestSkipped = light_grey,
        NeotestTarget = purple,
        NeotestTest = fg,
        NeotestUnknown = light_grey,

        -- nvim-tree.lua
        NvimTreeNormal = { fg = c.fg, bg = tree_bg },
        NvimTreeNormalFloat = { fg = c.fg, bg = tree_bg },
        NvimTreeVertSplit = { fg = c.bg_d, bg = tree_bg },
        NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = tree_bg },
        NvimTreeRootFolder = { fg = c.orange, fmt = 'bold' },
        NvimTreeGitDirty = yellow,
        NvimTreeGitNew = green,
        NvimTreeGitDeleted = red,
        NvimTreeSpecialFile = { fg = c.yellow, fmt = 'underline' },
        NvimTreeIndentMarker = fg,
        NvimTreeImageFile = { fg = c.dark_purple },
        NvimTreeSymlink = purple,
        NvimTreeFolderName = blue,

        -- aerial.nvim / symbols-outline
        FocusedSymbol = { fg = c.purple, bg = c.bg2, fmt = 'bold' },
        AerialLine = { fg = c.purple, bg = c.bg2, fmt = 'bold' },

        -- rainbow-delimiters.nvim and the older nvim-ts-rainbow(2)
        RainbowDelimiterRed = red,
        RainbowDelimiterYellow = yellow,
        RainbowDelimiterBlue = blue,
        RainbowDelimiterOrange = orange,
        RainbowDelimiterGreen = green,
        RainbowDelimiterViolet = purple,
        RainbowDelimiterCyan = cyan,
        TSRainbowRed = red,
        TSRainbowYellow = yellow,
        TSRainbowBlue = blue,
        TSRainbowOrange = orange,
        TSRainbowGreen = green,
        TSRainbowViolet = purple,
        TSRainbowCyan = cyan,
        rainbowcol1 = light_grey,
        rainbowcol2 = yellow,
        rainbowcol3 = blue,
        rainbowcol4 = orange,
        rainbowcol5 = purple,
        rainbowcol6 = green,
        rainbowcol7 = red,

        -- snacks.nvim (dashboard, picker)
        SnacksDashboardHeader = yellow,
        SnacksDashboardFooter = { fg = c.dark_red, fmt = 'italic' },
        SnacksDashboardSpecial = { fg = c.dark_red, fmt = 'bold' },
        SnacksDashboardDesc = cyan,
        SnacksDashboardIcon = cyan,
        SnacksDashboardKey = blue,
        SnacksPicker = { link = 'Normal' },
        SnacksPickerBorder = cyan,
        SnacksPickerTitle = red,
        SnacksPickerMatch = { fg = c.orange, fmt = 'bold' },

        -- telescope.nvim
        TelescopeBorder = red,
        TelescopePromptBorder = cyan,
        TelescopeResultsBorder = cyan,
        TelescopePreviewBorder = cyan,
        TelescopeMatching = { fg = c.orange, fmt = 'bold' },
        TelescopePromptPrefix = green,
        TelescopeSelection = { bg = c.bg2 },
        TelescopeSelectionCaret = yellow,

        -- which-key.nvim
        WhichKey = red,
        WhichKeyDesc = blue,
        WhichKeyGroup = orange,
        WhichKeySeparator = green,
    }

    for kind, color in pairs(kind_colors(c)) do
        groups['CmpItemKind' .. kind] = { fg = color, fmt = cmp_kind_fmt }
        groups['BlinkCmpKind' .. kind] = { fg = color }
        groups['Aerial' .. kind .. 'Icon'] = { fg = color }
        groups['NavicIcons' .. kind] = { fg = color }
        groups['DropBarKind' .. kind] = { fg = color }
    end

    return groups
end
