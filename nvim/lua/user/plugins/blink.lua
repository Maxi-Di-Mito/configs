---@diagnostic disable: missing-fields

-- LazyDev
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- Copilot
require("copilot").setup({
  server = { type = "binary" },
  suggestion = { enabled = false },
  panel = { enabled = false },
})

-- Blink.cmp
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  fuzzy = {},

  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
    providers = {
      lsp = { fallback_for = { "lazydev" } },
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
  signature = { enabled = true },
  completion = {
    menu = {
      border = "rounded",
    },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
      },
    },
  },
})
