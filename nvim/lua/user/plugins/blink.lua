---@diagnostic disable: missing-fields

return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    enabled = true,
    -- use a release tag to download pre-built binaries
    version = "v0.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      fuzzy = {
        -- frencency tracks the most recently/frequently used items and boosts the score of the item
        use_frecency = false,
      },

      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        },
        providers = {
          lsp = { fallback_for = { "lazydev" } },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
      -- experimental signature help support
      signature = { enabled = true },
      completion = {
        menu = {
          border = vim.g.border_style,
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          -- Controls whether the documentation window will automatically show when selecting a completion item
          auto_show = true,
          -- Delay before showing the documentation window
          auto_show_delay_ms = 200,
          window = {
            border = vim.g.border_style,
          },
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },
}
