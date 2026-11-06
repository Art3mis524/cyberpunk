-- Colour palettes, one per style. Both styles have the same keys, so every
-- highlight group works with either; neon is the same theme pushed towards
-- a near-black background and saturated colours.
--
-- Key names come from onedark.nvim (users reference them as `$name` in
-- `highlights` overrides), but several were re-coloured for this theme, so
-- go by role rather than name:
--
--   black bg_d bg0..bg3    backgrounds, darkest first (bg0 = editor)
--   fg light_grey grey     text, punctuation, comments and line numbers
--   purple                 keywords
--   yellow                 types and classes
--   orange                 numbers and constants
--   blue                   functions (green here, despite the name)
--   cyan                   namespaces, builtins, properties
--   green                  strings
--   rose                   parameters
--   red                    errors, builtin variables
--   bg_blue bg_yellow      selection and search backgrounds
--   dark_*                 muted diagnostics (diagnostics.darker)
--   diff_*                 diff backgrounds
return {
    dark = {
        black = '#121316',
        bg_d = '#16181d',
        bg0 = '#1e2128',
        bg1 = '#272a32',
        bg2 = '#2d323c',
        bg3 = '#2f333f',
        bg_blue = '#7295e8',
        bg_yellow = '#ebd09c',
        fg = '#d6d9df',
        light_grey = '#c2c5cc',
        grey = '#5c6370',
        purple = '#c678dd',
        yellow = '#e5b93e',
        orange = '#d97a3d',
        blue = '#42d787',
        cyan = '#56b6c2',
        green = '#98c379',
        rose = '#d685bb',
        red = '#e86671',
        dark_cyan = '#2b6f77',
        dark_red = '#993939',
        dark_yellow = '#93691d',
        dark_purple = '#8a3fa0',
        diff_add = '#31392b',
        diff_delete = '#382b2c',
        diff_change = '#1c3448',
        diff_text = '#2c5372',
    },
    neon = {
        black = '#08090b',
        bg_d = '#08090c',
        bg0 = '#0d0e12',
        bg1 = '#15171c',
        bg2 = '#1a1e24',
        bg3 = '#1c2027',
        bg_blue = '#7295e8',
        bg_yellow = '#ebd09c',
        fg = '#d6d9df',
        light_grey = '#c2c5cc',
        grey = '#5c6370',
        purple = '#d564f7',
        yellow = '#fac42e',
        orange = '#f67e31',
        blue = '#1ff984',
        cyan = '#34dff4',
        green = '#91f04c',
        rose = '#f25abf',
        red = '#f04c5a',
        dark_cyan = '#2b6f77',
        dark_red = '#993939',
        dark_yellow = '#93691d',
        dark_purple = '#8a3fa0',
        diff_add = '#31392b',
        diff_delete = '#382b2c',
        diff_change = '#1c3448',
        diff_text = '#2c5372',
    },
}
