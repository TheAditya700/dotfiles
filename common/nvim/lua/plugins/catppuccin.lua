return {
  -- Catppuccin theme configuration
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        dashboard = true,
        notify = true,
        leap = true,
        mason = true,
        neotree = true,
        semantic_tokens = true,
        vimwiki = true,
        headlines = true,
        -- Custom color overrides to match your Fish/eza theme
        color_overrides = {
          mocha = {
            base = "#1e1e2e", -- preferred_background from Fish theme
            mantle = "#181825",
            crust = "#11111b",
            text = "#cdd6f4", -- fish_color_normal
            subtext1 = "#bac2de", -- eza filekinds.normal
            subtext0 = "#a6adc8",
            overlay0 = "#6c7086", -- fish_color_gray
            overlay1 = "#7f849c", -- fish_color_comment
            overlay2 = "#9399b2",
            surface0 = "#313244", -- fish_color_selection background
            surface1 = "#45475a",
            surface2 = "#585b70",
            blue = "#89b4fa", -- fish_color_command, fish_color_host
            lavender = "#b4befe",
            sapphire = "#74c7ec",
            sky = "#89dceb", -- eza symlink color
            teal = "#94e2d5", -- fish_color_user
            green = "#a6e3a1", -- fish_color_quote, fish_color_option
            yellow = "#f9e2af", -- fish_color_cwd
            peach = "#fab387", -- fish_color_end
            maroon = "#eba0ac",
            red = "#f38ba8", -- fish_color_keyword, fish_color_error
            mauve = "#cba6f7", -- fish_color_operator, eza special
            pink = "#f5c2e7", -- fish_color_redirection, fish_pager_color_prefix
            flamingo = "#f2cdcd", -- fish_color_param
            rosewater = "#f5e0dc",
          },
        },
        highlight_overrides = {
          mocha = function(cp)
            return {
              -- Custom highlights to match your preferences
              NormalFloat = { fg = cp.text, bg = cp.base },
              FloatBorder = { fg = cp.surface1, bg = cp.base },
              CursorLineNr = { fg = cp.yellow },
              LineNr = { fg = cp.overlay0 },
              DiagnosticVirtualTextError = { fg = cp.red, style = { "italic" } },
              DiagnosticVirtualTextWarn = { fg = cp.yellow, style = { "italic" } },
              DiagnosticVirtualTextInfo = { fg = cp.blue, style = { "italic" } },
              DiagnosticVirtualTextHint = { fg = cp.teal, style = { "italic" } },
            }
          end,
        },
      },
    },
  },

  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}