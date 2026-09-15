# cyberpunk

A personal Neovim colorscheme, forked from [onedark.nvim](https://github.com/navarasu/onedark.nvim),
with two style variants:

- **`cyberpunk`** — the tuned base palette: darker background, distinct hues for
  types/numbers/functions/parameters/namespaces so nothing blends together, bold
  keywords (including `static_cast`-style operators — see note below), punctuation
  closer in brightness to regular text than onedark's default.
- **`cyberpunkNeon`** — the same theme, pushed further: near-black background,
  every syntax color boosted toward a high-saturation neon look.

Both variants share 100% of the same code (highlights, terminal colors, lualine
theme) — only the color values in `lua/cyberpunk/palette.lua` differ, under the
`dark` and `neon` keys. Fixing something in one variant fixes it in both.

## Install (lazy.nvim)

```lua
{
    "Art3mis524/cyberpunk",
    config = function()
        require("cyberpunk").setup({
            code_style = {
                keywords = "bold",
            },
        })
        vim.cmd.colorscheme "cyberpunk"       -- or "cyberpunkNeon" for the neon variant
    end
}
```

Switch between them any time with `:colorscheme cyberpunk` / `:colorscheme cyberpunkNeon` —
no need to re-run setup().

## Colors at a glance (both variants share the same roles, different intensity)

| Role | dark | neon |
|---|---|---|
| Background | `#1e2128` | `#0d0e12` |
| Keywords (bold) | `#c678dd` | `#d564f7` |
| Types (classes/structs) | `#e5b93e` | `#fac42e` |
| Numbers/constants | `#d97a3d` | `#f67e31` |
| Functions | `#42d787` | `#1ff984` |
| Namespaces / built-in functions | `#56b6c2` | `#34dff4` |
| Strings | `#98c379` | `#91f04c` |
| Parameters | `#d685bb` | `#f25abf` |
| Errors / builtins | `#e86671` | `#f04c5a` |

## Notes

- Only `dark` and `neon` have been tuned. The other onedark style variants
  (`darker`/`cool`/`deep`/`warm`/`warmer`/`light`) still have onedark's original colors —
  selectable via `style = "..."` in `setup()`, but not exposed as their own `:colorscheme` name here.
- `lua/lualine/themes/cyberpunk.lua` is included and works for both variants automatically
  (it reads whichever style is currently active) — set `theme = "cyberpunk"` in your lualine
  config regardless of which variant you're using.
- A C++ treesitter query override is **not** included here — if you want
  `static_cast`/`reinterpret_cast`/`const_cast`/`dynamic_cast` styled as keywords rather than
  function calls (the C++ grammar parses them as template function calls by default), add this
  as `after/queries/cpp/highlights.scm` in your own Neovim config:

  ```scheme
  ; extends
  ((identifier) @keyword
    (#any-of? @keyword "static_cast" "reinterpret_cast" "const_cast" "dynamic_cast")
    (#set! priority 110))
  ```
