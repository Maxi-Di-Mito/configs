return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "SmiteshP/nvim-navic",
  config = function()
    local utils = require("user.utils")

    -- import lspconfig plugin safely
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    -- import cmp-nvim-lsp plugin safely
    local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not cmp_nvim_lsp_status then
      return
    end

    local okNavic, navic = pcall(require, "nvim-navic")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local keymap = vim.keymap -- for conciseness

    -- enable keybinds only for when lsp server available
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
          [[
    augroup lsp_document_highlight
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END

  ]],
          false
        )
      end

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = augroup,
        callback = function()
          FormattingFunction()
        end,
      })

      if client.server_capabilities.documentSymbolProvider and okNavic then
        navic.attach(client, bufnr)
      end

      -- keybind options
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- set keybinds
      -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
      -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration
      -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
      -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
      -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- go to implementation
      -- keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions
      -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
      -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
      -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
      -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
      -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local simpleSetupServers = {
      "html",
      "cssls",
      "bashls",
      "jsonls",
      "dockerls",
      "gopls",
      -- "leminx", -- ver nombre o que onda
      "svelte",
      "taplo",
      "vimls",
      "yamlls",
    }

    for _, value in ipairs(simpleSetupServers) do
      lspconfig[value].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          format = { enable = false },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig["volar"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        typescript = {
          tsdk = utils.getTypescriptPath(),
        },
      },
      settings = {
        volar = {
          format = {
            initialIndent = {
              html = true,
              javascript = true,
              typescript = true,
              css = true,
              scss = true,
            },
          },
        },
      },
    })
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        diagnostics = {
          ignoredCodes = { 7016, 80001, 6133 }, -- 7016 types , 80001 this could be a module bleh, 6133 unused param
        },
      },
    })
  end,
}
