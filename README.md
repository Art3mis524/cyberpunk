# cyberpunk

A Neovim colorscheme in two styles, forked from
[onedark.nvim](https://github.com/navarasu/onedark.nvim):

- **`cyberpunk`**: dark background, a distinct hue for each of types, numbers,
  functions, parameters and namespaces so nothing blends together, bold keywords
  (including `static_cast`-style operators, see [below](#c-casts-as-keywords)),
  and punctuation close to the brightness of regular text.
- **`cyberpunkNeon`**: the same theme on a near-black background, with every
  syntax colour pushed towards neon.

Both styles share every highlight definition; only the palette in
`lua/cyberpunk/palette.lua` differs, so a fix to one fixes both.
Requires Neovim 0.10 or newer.

## Install (lazy.nvim)

```lua
{
    'Art3mis524/cyberpunk',
    lazy = false,
    priority = 1000, -- load before other plugins so they see its colours
    config = function()
        vim.cmd.colorscheme('cyberpunk') -- or 'cyberpunkNeon'
    end,
}
```

Switch at any time with `:colorscheme cyberpunk` or `:colorscheme cyberpunkNeon`.
Options passed to `setup()` carry over between the two.

## Options

Call `setup()` before `:colorscheme` to change any of these defaults:

```lua
require('cyberpunk').setup({
    transparent = false, -- leave the editor background unset
    term_colors = true, -- colour :terminal buffers from the palette
    ending_tildes = false, -- show ~ on the lines after the end of a buffer
    cmp_itemkind_reverse = false, -- nvim-cmp item kinds as reversed blocks
    toggle_style_key = nil, -- e.g. '<leader>ts' to cycle toggle_style_list
    toggle_style_list = { 'dark', 'neon' },

    -- 'none', or comma-separated 'bold', 'italic', 'underline', 'undercurl', ...
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'none',
        strings = 'none',
        variables = 'none',
        constants = 'none',
    },

    lualine = { transparent = false }, -- no background behind section c
    diagnostics = {
        darker = true, -- muted colours for virtual text
        undercurl = true, -- undercurl rather than underline
        background = true, -- tinted background behind virtual text
    },

    colors = {}, -- palette overrides: { bg0 = '#000000' }
    highlights = {}, -- group overrides: { Comment = { fg = '$cyan', fmt = 'none' } }
})
```

A `highlights` entry replaces only the fields it sets (`fg`, `bg`, `sp`, `fmt`,
or `link`), and `$name` refers to a palette colour.

## Colours

Both styles give each role the same hue at a different intensity:

| Role | `cyberpunk` | `cyberpunkNeon` |
|---|---|---|
| Background | `#1e2128` | `#0d0e12` |
| Keywords (bold) | `#c678dd` | `#d564f7` |
| Types (classes, structs) | `#e5b93e` | `#fac42e` |
| Numbers, constants | `#d97a3d` | `#f67e31` |
| Functions | `#42d787` | `#1ff984` |
| Namespaces, built-in functions | `#56b6c2` | `#34dff4` |
| Strings | `#98c379` | `#91f04c` |
| Parameters | `#d685bb` | `#f25abf` |
| Errors, built-in variables | `#e86671` | `#f04c5a` |

The palette keys keep onedark's names, so some don't match their colour (functions
use `blue`, which is green here); `lua/cyberpunk/palette.lua` lists each key's role.

## lualine

The included lualine theme follows whichever style is active:

```lua
require('lualine').setup({ options = { theme = 'cyberpunk' } })
```

## C++ casts as keywords

The C++ treesitter grammar parses `static_cast<T>(x)` and friends as template
function calls. To colour them as keywords instead, add this to your config as
`after/queries/cpp/highlights.scm`:

```scheme
; extends
((identifier) @keyword
  (#any-of? @keyword "static_cast" "reinterpret_cast" "const_cast" "dynamic_cast")
  (#set! priority 110))
```

## Development

```text
colors/                  :colorscheme entry points, one per style
lua/cyberpunk/init.lua   setup(), load(), toggle(), palette()
lua/cyberpunk/palette.lua
lua/cyberpunk/highlights.lua   collects groups/*.lua and applies them
lua/cyberpunk/groups/    editor UI, syntax, treesitter, LSP, languages, plugins
lua/lualine/themes/cyberpunk.lua
tests/run.lua
```

Run the tests (they also run on every push, see `.github/workflows/test.yml`):

```sh
nvim --clean --headless -l tests/run.lua
```

## License

MIT, keeping onedark.nvim's original notice. See [LICENSE](LICENSE).
