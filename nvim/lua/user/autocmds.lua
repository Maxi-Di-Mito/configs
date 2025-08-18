-- hightlight on YANK
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = "silent! lua vim.highlight.on_yank()",
  group = "highlight_yank",
})

-- GO Template files support
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.gohtml", "*.go.html", "*.html.gotmpl" },
  callback = function()
    vim.opt_local.filetype = "gohtmltmpl"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.gotmpl", "*.go.tmpl" },
  callback = function()
    vim.opt_local.filetype = "gotexttmpl"
  end,
})

-- Handlebars

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.hbs", "*.handlebars" },
  callback = function()
    vim.opt_local.filetype = "html"
  end,
})
