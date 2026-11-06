-- Per-language groups from Vim's regex syntax files, for filetypes without
-- a treesitter parser (and the few TS-prefixed groups some still define).
return function(c, cfg)
    local s = cfg.code_style
    local grey, purple, red = { fg = c.grey }, { fg = c.purple }, { fg = c.red }
    local blue, cyan, yellow = { fg = c.blue }, { fg = c.cyan }, { fg = c.yellow }
    local green, orange, fg = { fg = c.green }, { fg = c.orange }, { fg = c.fg }

    return {
        -- C / C++
        cInclude = blue,
        cStorageClass = purple,
        cTypedef = purple,
        cDefine = cyan,
        cTSInclude = blue,
        cTSConstant = cyan,
        cTSConstMacro = purple,
        cTSOperator = purple,
        cppStatement = { fg = c.purple, fmt = 'bold' },
        cppTSInclude = blue,
        cppTSConstant = cyan,
        cppTSConstMacro = purple,
        cppTSOperator = purple,

        -- Markdown
        markdownBlockquote = grey,
        markdownBold = { fmt = 'bold' },
        markdownBoldDelimiter = grey,
        markdownCode = green,
        markdownCodeBlock = green,
        markdownCodeDelimiter = yellow,
        markdownH1 = { fg = c.red, fmt = 'bold' },
        markdownH2 = { fg = c.purple, fmt = 'bold' },
        markdownH3 = { fg = c.orange, fmt = 'bold' },
        markdownH4 = { fg = c.red, fmt = 'bold' },
        markdownH5 = { fg = c.purple, fmt = 'bold' },
        markdownH6 = { fg = c.orange, fmt = 'bold' },
        markdownHeadingDelimiter = grey,
        markdownHeadingRule = grey,
        markdownId = yellow,
        markdownIdDeclaration = red,
        markdownItalic = { fmt = 'italic' },
        markdownItalicDelimiter = { fg = c.grey, fmt = 'italic' },
        markdownLinkDelimiter = grey,
        markdownLinkText = red,
        markdownLinkTextDelimiter = grey,
        markdownListMarker = red,
        markdownOrderedListMarker = red,
        markdownRule = purple,
        markdownUrl = { fg = c.blue, fmt = 'underline' },
        markdownUrlDelimiter = grey,
        markdownUrlTitleDelimiter = green,

        -- PHP
        phpFunctions = { fg = c.fg, fmt = s.functions },
        phpMethods = cyan,
        phpStructure = purple,
        phpOperator = purple,
        phpMemberSelector = fg,
        phpVarSelector = { fg = c.orange, fmt = s.variables },
        phpIdentifier = { fg = c.orange, fmt = s.variables },
        phpBoolean = cyan,
        phpNumber = orange,
        phpHereDoc = green,
        phpNowDoc = green,
        phpSCKeyword = { fg = c.purple, fmt = s.keywords },
        phpFCKeyword = { fg = c.purple, fmt = s.keywords },
        phpRegion = blue,

        -- Scala
        scalaNameDefinition = fg,
        scalaInterpolationBoundary = purple,
        scalaInterpolation = purple,
        scalaTypeOperator = red,
        scalaOperator = red,
        scalaKeywordModifier = { fg = c.red, fmt = s.keywords },

        -- TeX / LaTeX (incl. vimtex)
        latexTSInclude = blue,
        latexTSFuncMacro = { fg = c.fg, fmt = s.functions },
        latexTSEnvironment = { fg = c.cyan, fmt = 'bold' },
        latexTSEnvironmentName = yellow,
        latexTSTitle = green,
        latexTSType = blue,
        latexTSMath = orange,
        texCmdEnv = cyan,
        texEnvArgName = yellow,
        texMathZoneX = orange,
        texMathZoneXX = orange,
        texMathDelimZone = { fg = c.light_grey },
        texMathDelim = purple,
        texMathOper = red,
        texCmd = purple,
        texCmdPart = blue,
        texCmdPackage = blue,
        texPgfType = yellow,

        -- Vim script
        vimOption = red,
        vimSetEqual = yellow,
        vimMap = purple,
        vimMapModKey = orange,
        vimNotation = red,
        vimMapLhs = fg,
        vimMapRhs = blue,
        vimVar = { fg = c.fg, fmt = s.variables },
        vimCommentTitle = { fg = c.light_grey, fmt = s.comments },
    }
end
