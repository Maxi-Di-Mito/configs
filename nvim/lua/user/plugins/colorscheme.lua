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
  local underline = !utils.isTermux()
  extendGroup("LspReferenceRead", { bold = true, underline = underline })
  extendGroup("LspReferenceWrite", { bold = true, underline = underline })
  extendGroup("LspReferenceText", { bold = true, underline = underline })
  extendGroup("Keyword", { italic = true })
end

-- set theme for lualine
LualineTheme = "nightfox"
return {
  {
    "sainnhe/everforest",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      LualineTheme = "everforest"
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
      vim.g.everforest_transparent_background = 1
      vim.cmd.colorscheme("everforest")
      setReferencesStyles()
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    config = function()
      require("rose-pine").setup({
        -- variant = "moon",
        dim_inactive_windows = true,
        style = {
          transparency = true,
        },
      })

      vim.cmd("colorscheme rose-pine-moon")
      LualineTheme = "rose-pine"

      ColorMyPencils()
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
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

      local okf = vim.cmd("colorscheme catppuccin-mocha")
      if not okf then
        print("there was a problem loading the colorscheme")
      end
      LualineTheme = "catppuccin"

      vim.cmd("hi LspReferenceText cterm=bold gui=bold")
      vim.cmd("hi LspReferenceRead cterm=bold gui=bold")
      vim.cmd("hi LspReferenceWrite cterm=bold gui=bold")
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      local fox = require("nightfox")
      -- local grub = require("gruvbox")

      fox.setup({
        options = {
          dim_inactive = false,
          transparent = true,
        },
        styles = { -- Style to be applied to different syntax groups
          comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          -- conditionals = "NONE",
          -- constants = "NONE",
          -- functions = "NONE",
          keywords = "italic",
          -- numbers = "NONE",
          -- operators = "NONE",
          -- strings = "NONE",
          -- types = "NONE",
          -- variables = "NONE",
        },
      })

      local okf = vim.cmd("colorscheme duskfox")
      if not okf then
        print("there was a problem loading the colorscheme")
      end
      LualineTheme = "nightfox"

      -- hightlight with bold font the current keyword under cursor
      -- vim.cmd("highlight LspReferenceText gui=bold")
      -- vim.cmd("highlight LspReferenceRead gui=bold")
      -- vim.cmd("highlight LspReferenceWrite gui=bold")
      setReferencesStyles()
      -- grub.setup({
      -- 	dim_inactive = true,
      -- })

      -- pcall(vim.cmd, "colorscheme gruvbox")
    end,
  },

  {
    "folke/tokyonight.nvim",
    enabled = false,
    config = function()
      ---@class tokyonight.Config
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        style = "moon",
        dim_inactive = true,
        styles = {
          keywords = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },
        transparent = true,
        lualine_bold = true,
      })

      vim.cmd("colorscheme tokyonight-moon")
      LualineTheme = "tokyonight"

      setReferencesStyles()
      -- vim.cmd("highlight LspReferenceText gui=bold")
      -- vim.cmd("highlight LspReferenceRead gui=bold")
      -- vim.cmd("highlight LspReferenceWrite gui=bold")
    end,
  },
}
