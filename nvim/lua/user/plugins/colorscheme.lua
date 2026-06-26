local utils = require("user.utils")

function ColorMyPencils()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local function extendGroup(name, styles)
  local hi = vim.api.nvim_get_hl(0, { name = name })
  vim.api.nvim_set_hl(0, name, vim.tbl_extend("keep", hi, styles))
end

local function setReferencesStyles()
  local underline = not utils.isTermux()
  extendGroup("LspReferenceRead", { bold = true, underline = underline })
  extendGroup("LspReferenceWrite", { bold = true, underline = underline })
  extendGroup("LspReferenceText", { bold = true, underline = underline })
  extendGroup("Keyword", { italic = true })
end

LualineTheme = "catppuccin"

require("catppuccin").setup({
  transparent_background = true,
  dim_inactive = {
    enabled = false,
    percentaje = 0.2,
  },
  integrations = {
    neotree = true,
    navic = {
      enabled = true,
    },
  },
  styles = {
    comments = { "italic" },
    keywords = { "italic" },
  },
})

local okf = vim.cmd("colorscheme catppuccin-mocha")
if not okf then
  print("there was a problem loading the colorscheme")
end
LualineTheme = "catppuccin"

vim.cmd("hi LspReferenceText cterm=bold gui=bold")
vim.cmd("hi LspReferenceRead cterm=bold gui=bold")
vim.cmd("hi LspReferenceWrite cterm=bold gui=bold")
setReferencesStyles()

-- Disabled colorschemes (change enabled to true and swap to activate):
-- everforest: LualineTheme = "everforest"
-- rose-pine: LualineTheme = "rose-pine"
-- nightfox: LualineTheme = "nightfox"
-- tokyonight: LualineTheme = "tokyonight"
