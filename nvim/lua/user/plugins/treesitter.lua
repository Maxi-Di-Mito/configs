require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "query", "typescript", "javascript", "html", "vue", "pug",
})

vim.treesitter.language.register("html", "gohtmltmpl")

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.bo[args.buf].filetype == "yaml" then
      return
    end
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

local wk = require("which-key")

wk.add({
  { "<leader>T", group = "Treesitter" },
})

vim.keymap.set("n", "<leader>Ti", ":TSInfo<cr>", { desc = "Info" })

require("treesitter-context").setup()
require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
