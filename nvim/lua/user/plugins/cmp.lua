return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "onsails/lspkind.nvim" }, -- vs-code like pictograms
    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
          server = {
            type = "binary",
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<C-l>",
              accept_word = false,
              accept_line = false,
              next = "<C-j>",
              prev = "<C-k>",
              dismiss = "<C-h>",
            },
          },
          panel = { enabled = true, auto_refresh = true },
        })
        -- toggle copilot suggestion
        vim.keymap.set("n", "<leader>ct", function()
          require("copilot.suggestion").toggle_auto_trigger()
        end, { desc = "Toggle Copilot Suggestion" })
      end,
    },
  },
  config = function()
    -- import nvim-cmp plugin safely
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      return
    end

    -- import luasnip plugin safely
    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then
      return
    end

    local lspkind = require("lspkind")
    lspkind.init({})
    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert, select = true }),
          { "i", "c" }
        ),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
    })

    luasnip.config.set_config({
      history = false,
      updateevents = "TextChanged,TextChangedI",
    })

    -- vim.keymap.set({ "i", "s" }, "<c-l>", function()
    vim.keymap.set({ "s" }, "<c-l>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    -- vim.keymap.set({ "i", "s" }, "<c-h>", function()
    vim.keymap.set({ "s" }, "<c-h>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })
  end,
}
