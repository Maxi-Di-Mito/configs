-- hightlight on YANK
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = "silent! lua vim.highlight.on_yank()",
  group = "highlight_yank",
})

--[[ vim.api.nvim_create_augroup("gitsignsFixAttach", { clear = true }) ]]
--[[ vim.api.nvim_create_autocmd({ "BufNew" }, { ]]
--[[ 	command = "Gitsigns attach", ]]
--[[ 	group = "gitsignsFixAttach", ]]
--[[ }) ]]
--

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    if require("lazy.core.config").plugins["neominimap.nvim"]._.loaded ~= nil then
      vim.cmd("Neominimap on")
    else
    end
  end,
})
