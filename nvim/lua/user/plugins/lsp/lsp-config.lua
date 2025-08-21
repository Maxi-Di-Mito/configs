return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- { "williamboman/mason-lspconfig.nvim" },
    { "nvimtools/none-ls.nvim" },
  },
  config = function()
    local utils = require("user.utils")
    local util = require("lspconfig/util")
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

        opts.desc = "Buffer Diagnostics"
        keymap.set("n", "<leader>ld", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", opts)

        opts.desc = "Show documentation"
        keymap.set("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded" })
        end, opts) -- show documentation for what is under cursor

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

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({ virtual_text = true })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
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
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
      settings = {
        json = {
          validate = { enable = true },
          schemas = require("schemastore").json.schemas(),
        },
      },
    })
    vim.lsp.config("eslint", {
      -- capabilities = capabilities,
      -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      codeActionOnSave = {
        rules = { "!jsdoc/" },
        mode = "all",
      },
      settings = {
        useFlatConfig = false,
        workingDirectory = { mode = "auto" },
      },
      root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "package.json", ".git" },
    })
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
      settings = {
        gopls = {
          -- see ftdetect/go.lua.
          ["build.templateExtensions"] = { "gohtml", "html", "gotmpl", "tmpl" },
        },
      },
    })
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.config("html", {
      capabilities = capabilities,
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
        provideFormatter = true,
      },
      filetypes = { "html", "gohtmltmpl", "handlebars" },
    })
    vim.lsp.config("htmx", {
      capabilities = capabilities,
      filetypes = { "html", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    })
    vim.lsp.config("vue_ls", {
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
    -- vim.lsp.config("vtsls", {
    --   capabilities = capabilities,
    --   cmd = { "vtsls", "--stdio" },
    --   filetypes = { "vue", "typescript", "javascript", "javascriptreact" },
    -- })
    -- vim.lsp.config("vuels", {
    --   capabilities = capabilities,
    --   cmd = { "vls" },
    --   settings = {
    --     vetur = {
    --       format = {
    --         enable = false,
    --       },
    --     },
    --   },
    -- })
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      root_markers = { "tsconfig.json", "tsconfig.js", "jsconfig.js", "jsconfig.json", "package.json", ".git" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      capabilities = capabilities,
      settings = {
        diagnostics = {
          ignoredCodes = { 7016, 80001, 6133, 80006 }, -- 7016 types , 80001 this could be a module bleh, 6133 unused param, 80006 can be an async function
        },
      },
      -- root_dir = function(fname)
      --   return lspconfig.util.root_pattern(".git")(fname)
      -- return lspconfig.util.root_pattern("tsconfig.json")(fname)
      --   or lspconfig.util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
      -- end,
    })
    vim.lsp.config("bashls", {
      capabilities = capabilities,
      filetypes = { "sh", "bash", "zsh" },
    })

    vim.lsp.enable({
      "bashls",
      "ts_ls",
      "html",
      "eslint",
      "cssls",
      "lua_ls",
      "vue_ls",
      -- "vuels",
      "gopls",
      "bashls",
      "jsonls",
      "dockerls",
      "taplo",
      "yamlls",
      -- "vtsls",
    })
  end,
}
