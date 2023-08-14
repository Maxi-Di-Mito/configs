local fox = require("nightfox")
-- local grub = require("gruvbox")

fox.setup({
  options = {
    dim_inactive = true,
  },
})

local okf = pcall(vim.cmd, "colorscheme nightfox")
if not okf then
  print("there was a problem loading the colorscheme")
end

-- hightlight with bold font the current keyword under cursor
vim.cmd("highlight LspReferenceText gui=bold")
vim.cmd("highlight LspReferenceRead gui=bold")
vim.cmd("highlight LspReferenceWrite gui=bold")

-- grub.setup({
-- 	dim_inactive = true,
-- })

-- pcall(vim.cmd, "colorscheme gruvbox")
