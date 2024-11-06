---@diagnostic disable: param-type-mismatch

LualineTheme = "rose-pine"

---@diagnostic disable-next-line: unused-local
local rosepine = {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      -- variant = "moon",
      dim_inactive_windows = true,
      style = {
        transparency = true,
      },
    })
    vim.cmd("colorscheme rose-pine")
    LualineTheme = "rose-pine"

    -- ColorMyPencils()
  end,
}

function ColorMyPencils()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

---@diagnostic disable-next-line: unused-local
local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        -- shade = "grey",
        percentaje = 0.2,
      },
      integrations = {
        neotree = true,
        navic = {
          enabled = true,
        },
      },
    })

    local okf = pcall(vim.cmd, "colorscheme catppuccin-mocha")
    if not okf then
      print("there was a problem loading the colorscheme")
    end
    LualineTheme = "catppuccin"

    vim.cmd("highlight LspReferenceText gui=bold")
    vim.cmd("highlight LspReferenceRead gui=bold")
    vim.cmd("highlight LspReferenceWrite gui=bold")

    vim.cmd("hi LspReferenceText cterm=bold gui=bold")
    vim.cmd("hi LspReferenceRead cterm=bold gui=bold")
    vim.cmd("hi LspReferenceWrite cterm=bold gui=bold")
  end,
}

---@diagnostic disable-next-line: unused-local
local nightfox = {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
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
    LualineTheme = "nightfox"

    -- hightlight with bold font the current keyword under cursor
    vim.cmd("highlight LspReferenceText gui=bold")
    vim.cmd("highlight LspReferenceRead gui=bold")
    vim.cmd("highlight LspReferenceWrite gui=bold")

    -- grub.setup({
    -- 	dim_inactive = true,
    -- })

    -- pcall(vim.cmd, "colorscheme gruvbox")
  end,
}

---@diagnostic disable-next-line: unused-local
local tokyo = {
  "folke/tokyonight.nvim",
  config = function()
    ---@class tokyonight.Config
    ---@diagnostic disable-next-line: missing-fields
    require("tokyonight").setup({
      dim_inactive = true,
      styles = {
        keywords = { italic = true },
      },
    })

    vim.cmd("colorscheme tokyonight")
    LualineTheme = "tokyonight"

    vim.cmd("highlight LspReferenceText gui=bold")
    vim.cmd("highlight LspReferenceRead gui=bold")
    vim.cmd("highlight LspReferenceWrite gui=bold")
  end,
}
return tokyo
