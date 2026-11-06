-- LSP: semantic tokens, diagnostics, references and code lenses.
local util = require('cyberpunk.util')

return function(c, cfg)
    local d = cfg.diagnostics
    local line = d.undercurl and 'undercurl' or 'underline'

    -- Virtual text: the diagnostic colour (muted when diagnostics.darker) on
    -- a faint tint of it (when diagnostics.background).
    local function virtual_text(color, muted, fmt)
        color = d.darker and muted or color
        return {
            fg = color,
            bg = d.background and util.darken(color, 0.1, c.bg0) or c.none,
            fmt = fmt,
        }
    end

    return {
        -- Semantic tokens reuse the matching treesitter colours.
        ['@lsp.type.comment'] = { link = '@comment' },
        ['@lsp.type.enum'] = { link = '@type' },
        ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
        ['@lsp.type.interface'] = { link = '@type' },
        ['@lsp.type.typeParameter'] = { link = '@type' },
        ['@lsp.type.keyword'] = { link = '@keyword' },
        ['@lsp.type.namespace'] = { link = '@module' },
        ['@lsp.type.parameter'] = { link = '@variable.parameter' },
        ['@lsp.type.property'] = { link = '@property' },
        ['@lsp.type.variable'] = { link = '@variable' },
        ['@lsp.type.macro'] = { link = '@function.macro' },
        ['@lsp.type.method'] = { link = '@function.method' },
        ['@lsp.type.number'] = { link = '@number' },
        ['@lsp.type.builtinType'] = { link = '@type.builtin' },
        ['@lsp.typemod.method.defaultLibrary'] = { link = '@function' },
        ['@lsp.typemod.function.defaultLibrary'] = { link = '@function' },
        ['@lsp.typemod.operator.injected'] = { link = '@operator' },
        ['@lsp.typemod.string.injected'] = { link = '@string' },
        ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
        ['@lsp.typemod.variable.injected'] = { link = '@variable' },
        ['@lsp.typemod.variable.static'] = { link = '@constant' },

        DiagnosticError = { fg = c.red },
        DiagnosticWarn = { fg = c.yellow },
        DiagnosticInfo = { fg = c.cyan },
        DiagnosticHint = { fg = c.purple },
        DiagnosticOk = { fg = c.green },
        DiagnosticUnnecessary = { fg = c.grey },
        DiagnosticDeprecated = { fg = c.orange, fmt = 'strikethrough' },

        DiagnosticVirtualTextError = virtual_text(c.red, c.dark_red),
        DiagnosticVirtualTextWarn = virtual_text(c.yellow, c.dark_yellow),
        DiagnosticVirtualTextInfo = virtual_text(c.cyan, c.dark_cyan),
        DiagnosticVirtualTextHint = virtual_text(c.purple, c.dark_purple),
        DiagnosticVirtualTextOk = virtual_text(c.green, c.green),
        DiagnosticVirtualTextUnnecessary = virtual_text(c.grey, c.grey),
        DiagnosticVirtualTextDeprecated = virtual_text(c.orange, c.orange, 'strikethrough'),

        DiagnosticUnderlineError = { fmt = line, sp = c.red },
        DiagnosticUnderlineWarn = { fmt = line, sp = c.yellow },
        DiagnosticUnderlineInfo = { fmt = line, sp = c.blue },
        DiagnosticUnderlineHint = { fmt = line, sp = c.purple },
        DiagnosticUnderlineOk = { fmt = line, sp = c.green },
        DiagnosticUnderlineUnnecessary = { fmt = line, sp = c.grey },
        DiagnosticUnderlineDeprecated = { fmt = 'strikethrough', sp = c.orange },

        LspReferenceText = { bg = c.bg2 },
        LspReferenceRead = { bg = c.bg2 },
        LspReferenceWrite = { bg = c.bg2 },
        LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
        LspCodeLensSeparator = { fg = c.grey },

        -- vim-lsp-cxx-highlight
        LspCxxHlGroupEnumConstant = { fg = c.orange },
        LspCxxHlGroupMemberVariable = { fg = c.orange },
        LspCxxHlGroupNamespace = { fg = c.blue },
        LspCxxHlSkippedRegion = { fg = c.grey },
        LspCxxHlSkippedRegionBeginEnd = { fg = c.red },
    }
end
