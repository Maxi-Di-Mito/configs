return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "query", "typescript", "javascript", "html", "vue" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true, disable = { "yaml" } },
      autopairs = {
        enable = true,
      },
      auto_install = true,
      -- disable treesitter on BIG files
      ---@diagnostic disable-next-line: unused-local
      disable = function(lang, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 5000
      end,
    })

    vim.treesitter.language.register("html", "gohtmltmpl") --

    local wk = require("which-key")

    wk.add({
      { "<leader>T", group = "Treesitter" },
    })

    vim.keymap.set("n", "<leader>Ti", ":TSConfigInfo<cr>", { desc = "Info" })

    require("treesitter-context").setup()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
  end,
}
