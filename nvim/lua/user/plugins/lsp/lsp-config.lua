return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
    { "SmiteshP/nvim-navic" },
    { "folke/neodev.nvim", opts = {}, event = "VeryLazy" },
  },
  config = function()
    local utils = require("user.utils")

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local navic = require("nvim-navic")

    navic.setup({
      highlight = true,
    })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local keymap = vim.keymap -- for conciseness

    -- enable keybinds only for when lsp server available
    --
    local wk = require("which-key")

    wk.add({
      { "<leader>l", group = "LSP" },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      -- Use a sharp border with `FloatBorder` highlights
      border = "single",
    })
    vim.diagnostic.config({
      float = { border = "single" },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = { buffer = ev.buf, silent = true }

        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = ev.buf,
            group = augroup,
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          })
          vim.api.nvim_create_autocmd("CursorHoldI", {
            buffer = ev.buf,
            group = augroup,
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = ev.buf,
            group = augroup,
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          })
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = ev.buf,
          group = augroup,
          callback = function()
            FormattingFunction()
          end,
        })

        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, ev.buf)
        end
        opts.desc = "Buffer Diagnostics"
        keymap.set("n", "<leader>ld", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", opts)

        opts.desc = "Show documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
        --TODO CHECK K = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },

        opts.desc = "Code Actions"
        keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        opts.desc = "Format"
        keymap.set("n", "<leader>lf", "<cmd>lua FormattingFunction(true)<cr>", opts)

        opts.desc = "Info"
        keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")

        opts.desc = "Next Diagnostic"
        keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
        opts.desc = "Prev Diagnostic"
        keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)

        opts.desc = "Rename"
        keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local root_pattern = require("lspconfig.util").root_pattern

    mason_lspconfig.setup_handlers({
      function(serverName)
        lspconfig[serverName].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = { -- custom settings for lua
            Lua = {
              runtime = { version = "LuaJIT" },
              -- make the language server recognize "vim" global
              diagnostics = {
                -- globals = { "vim" },
              },
              format = { enable = false },
              workspace = {
                checkThirdParty = false,
                -- make language server aware of runtime files
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
            },
          },
        })
      end,
      ["jsonls"] = function()
        lspconfig["jsonls"].setup({
          capabilities = capabilities,
          settings = {
            json = {
              validate = { enable = true },
              schemas = require("schemastore").json.schemas(),
            },
          },
        })
      end,
      ["eslint"] = function()
        lspconfig["eslint"].setup({
          capabilities = capabilities,
          root_dir = root_pattern(".git"),
          codeActionOnSave = {
            rules = { "!jsdoc/" },
            mode = "all",
          },
          -- root_dir = root_pattern(".eslintrc.js", ".eslintrc.json", "node_modules", ".git"),
          settings = {
            -- workingDirectory = { mode = "auto" },
          },
        })
      end,
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
          settings = {
            gopls = {
              -- see ftdetect/go.lua.
              ["build.templateExtensions"] = { "gohtml", "html", "gotmpl", "tmpl" },
            },
          },
        })
      end,
      ["htmx"] = function()
        lspconfig["htmx"].setup({
          capabilities = capabilities,
          filetypes = { "gotmpl", "gohtmltmpl", "gotexttmpl" },
        })
      end,
      ["volar"] = function()
        lspconfig["volar"].setup({
          capabilities = capabilities,
          init_options = {
            typescript = {
              tsdk = utils.getTypescriptPath(),
            },
          },
          settings = {
            vue = {
              format = {
                template = {
                  initialIndent = true,
                },
                script = {
                  initialIndent = true,
                },
                style = {
                  initialIndent = true,
                },
              },
            },
          },
        })
      end,
      ["vuels"] = function()
        lspconfig["vuels"].setup({
          settings = {
            vetur = {
              format = {
                enable = false,
              },
            },
          },
        })
      end,
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          settings = {
            diagnostics = {
              ignoredCodes = { 7016, 80001, 6133, 80006 }, -- 7016 types , 80001 this could be a module bleh, 6133 unused param, 80006 can be an async function
            },
          },
          root_dir = function(fname)
            return lspconfig.util.root_pattern(".git")(fname)
            -- return lspconfig.util.root_pattern("tsconfig.json")(fname)
            --   or lspconfig.util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
          end,
        })
      end,
      ["html"] = function()
        lspconfig["html"].setup({
          capabilities = capabilities,
          filetypes = { "html", "gohtmltmpl" },
        })
      end,
      ["bashls"] = function()
        lspconfig["bashls"].setup({
          capabilities = capabilities,
          filetypes = { "sh", "bash", "zsh" },
        })
      end,
    })
  end,
}
