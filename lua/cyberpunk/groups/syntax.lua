-- Standard :syntax groups (see :help group-name). Treesitter captures that
-- have no theme colour of their own fall back to these.
return function(c, cfg)
    local s = cfg.code_style
    local keyword = { fg = c.purple, fmt = s.keywords }

    return {
        Comment = { fg = c.grey, fmt = s.comments },
        SpecialComment = { fg = c.grey, fmt = s.comments },
        Todo = { fg = c.red, fmt = s.comments },

        Constant = { fg = c.cyan },
        String = { fg = c.green, fmt = s.strings },
        Character = { fg = c.orange },
        Number = { fg = c.orange },
        Float = { fg = c.orange },
        Boolean = { fg = c.orange },

        Identifier = { fg = c.red, fmt = s.variables },
        Function = { fg = c.blue, fmt = s.functions },

        Statement = { fg = c.purple },
        Keyword = keyword,
        Conditional = keyword,
        Repeat = keyword,
        Label = { fg = c.purple },
        Operator = { fg = c.purple },
        Exception = { fg = c.purple },

        PreProc = { fg = c.purple },
        PreCondit = { fg = c.purple },
        Include = { fg = c.purple },
        Define = { fg = c.purple },
        Macro = { fg = c.red },

        Type = { fg = c.yellow },
        Structure = { fg = c.yellow },
        StorageClass = { fg = c.yellow },
        Typedef = { fg = c.yellow },

        Special = { fg = c.red },
        SpecialChar = { fg = c.red },
        Tag = { fg = c.green },
        Delimiter = { fg = c.light_grey },
        Title = { fg = c.cyan },
        Error = { fg = c.purple },
    }
end
