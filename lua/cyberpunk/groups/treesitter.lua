-- Treesitter captures (see :help treesitter-highlight-groups).
return function(c, cfg)
    local s = cfg.code_style
    local function comment(color)
        return { fg = color, fmt = s.comments }
    end
    local function keyword(color)
        return { fg = color, fmt = s.keywords }
    end
    local func = { fg = c.blue, fmt = s.functions }
    local builtin_func = { fg = c.cyan, fmt = s.functions }
    local constant = { fg = c.orange, fmt = s.constants }
    local string = { fg = c.green, fmt = s.strings }

    return {
        ['@attribute'] = { fg = c.cyan },
        ['@attribute.builtin'] = { fg = c.blue },

        ['@boolean'] = { fg = c.orange },
        ['@character'] = { fg = c.orange },
        ['@character.special'] = { fg = c.red },
        ['@number'] = { fg = c.orange },
        ['@number.float'] = { fg = c.orange },

        ['@comment'] = comment(c.grey),
        ['@comment.documentation'] = comment(c.grey),
        ['@comment.error'] = comment(c.red),
        ['@comment.note'] = comment(c.blue),
        ['@comment.todo'] = comment(c.purple),
        ['@comment.warning'] = comment(c.yellow),

        ['@constant'] = constant,
        ['@constant.builtin'] = constant,
        ['@constant.macro'] = constant,
        ['@constructor'] = { fg = c.yellow, fmt = 'bold' },

        ['@diff.plus'] = { link = 'DiffAdded' },
        ['@diff.minus'] = { link = 'DiffDeleted' },
        ['@diff.delta'] = { link = 'DiffChanged' },

        ['@function'] = func,
        ['@function.call'] = func,
        ['@function.method'] = func,
        ['@function.method.call'] = func,
        ['@function.builtin'] = builtin_func,
        ['@function.macro'] = builtin_func,

        ['@keyword'] = keyword(c.purple),
        ['@keyword.conditional'] = keyword(c.purple),
        ['@keyword.conditional.ternary'] = keyword(c.purple),
        ['@keyword.coroutine'] = keyword(c.purple),
        ['@keyword.debug'] = keyword(c.red),
        ['@keyword.directive'] = keyword(c.purple),
        ['@keyword.directive.define'] = keyword(c.purple),
        ['@keyword.exception'] = keyword(c.purple),
        ['@keyword.function'] = { fg = c.purple, fmt = s.functions },
        ['@keyword.import'] = keyword(c.purple),
        ['@keyword.modifier'] = keyword(c.purple),
        ['@keyword.operator'] = keyword(c.purple),
        ['@keyword.repeat'] = keyword(c.purple),
        ['@keyword.return'] = keyword(c.purple),
        ['@keyword.type'] = keyword(c.purple),

        ['@label'] = { fg = c.red },

        -- Markup (markdown and friends)
        ['@markup.strong'] = { fg = c.fg, fmt = 'bold' },
        ['@markup.italic'] = { fg = c.fg, fmt = 'italic' },
        ['@markup.strikethrough'] = { fg = c.fg, fmt = 'strikethrough' },
        ['@markup.underline'] = { fg = c.fg, fmt = 'underline' },
        ['@markup.heading'] = { fg = c.orange, fmt = 'bold' },
        ['@markup.heading.1'] = { fg = c.red, fmt = 'bold' },
        ['@markup.heading.2'] = { fg = c.purple, fmt = 'bold' },
        ['@markup.heading.3'] = { fg = c.orange, fmt = 'bold' },
        ['@markup.heading.4'] = { fg = c.red, fmt = 'bold' },
        ['@markup.heading.5'] = { fg = c.purple, fmt = 'bold' },
        ['@markup.heading.6'] = { fg = c.orange, fmt = 'bold' },
        ['@markup.link'] = { fg = c.blue },
        ['@markup.link.label'] = { fg = c.cyan },
        ['@markup.link.url'] = { fg = c.cyan, fmt = 'underline' },
        ['@markup.list'] = { fg = c.red },
        ['@markup.list.checked'] = comment(c.green),
        ['@markup.list.unchecked'] = comment(c.red),
        ['@markup.math'] = { fg = c.fg },
        ['@markup.quote'] = { fg = c.grey, fmt = 'italic' },
        ['@markup.raw'] = { fg = c.green },
        ['@markup.raw.block'] = { fg = c.green },

        ['@module'] = { fg = c.cyan },
        ['@module.builtin'] = { fg = c.orange },
        ['@none'] = { fg = c.fg },
        ['@conceal'] = { fg = c.grey },
        ['@operator'] = { fg = c.fg },
        ['@property'] = { fg = c.cyan },

        ['@punctuation.bracket'] = { fg = c.light_grey },
        ['@punctuation.delimiter'] = { fg = c.light_grey },
        ['@punctuation.special'] = { fg = c.red },

        ['@string'] = string,
        ['@string.documentation'] = string,
        ['@string.special.path'] = string,
        ['@string.escape'] = { fg = c.red, fmt = s.strings },
        ['@string.regexp'] = { fg = c.orange, fmt = s.strings },
        ['@string.special'] = { fg = c.dark_cyan, fmt = s.strings },
        ['@string.special.symbol'] = { fg = c.cyan },
        ['@string.special.url'] = { fg = c.cyan, fmt = 'underline' },

        -- Tags (HTML, JSX/TSX, XML)
        ['@tag'] = { fg = c.purple },
        ['@tag.builtin'] = { fg = c.purple },
        ['@tag.attribute'] = { fg = c.yellow },
        ['@tag.delimiter'] = { fg = c.purple },

        ['@type'] = { fg = c.yellow },
        ['@type.builtin'] = { fg = c.orange },
        ['@type.definition'] = { fg = c.yellow },

        ['@variable'] = { fg = c.fg, fmt = s.variables },
        ['@variable.builtin'] = { fg = c.red, fmt = s.variables },
        ['@variable.member'] = { fg = c.cyan },
        ['@variable.parameter'] = { fg = c.rose },
        ['@variable.parameter.builtin'] = { fg = c.orange, fmt = s.variables },
    }
end
