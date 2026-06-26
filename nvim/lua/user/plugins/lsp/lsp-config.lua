local utils = require("user.utils")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local keymap = vim.keymap
local wk = require("which-key")

wk.add({
  { "<leader>l", group = "LSP" },
})

vim.diagnostic.config({
  virtual_text = true,
  float = { border = "single" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰛩 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
    },
  },
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

    -- ESLint fix on save (conform handles the rest)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      group = augroup,
      callback = function()
        pcall(vim.cmd, "EslintFixAll")
      end,
    })

    opts.desc = "Buffer Diagnostics"
    keymap.set("n", "<leader>ld", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", opts)

    opts.desc = "Show documentation"
    keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, opts)

    opts.desc = "Code Actions"
    keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

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

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {},
      format = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
          "${3rd}/love2d/library",
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
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server", "--stdio" },
  capabilities = capabilities,
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, {
      "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
      "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
      ".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
      ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
      "package.json", ".git",
    })
    if root then on_dir(root) end
  end,
  settings = {
    workingDirectory = { mode = "auto" },
    autofixOnSave = true,
    codeActionOnSave = {
      rules = { "!jsdoc/" },
      mode = "all",
    },
    experimental = {
      useFlatConfig = true,
    },
  },
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  settings = {
    gopls = {
      ["build.templateExtensions"] = { "gohtml", "html", "gotmpl", "tmpl" },
    },
  },
})

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
  on_init = function(client)
    local retries = 0
    local function typescriptHandler(_, result, context)
      local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
        or vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
      if not ts_client then
        if retries <= 10 then
          retries = retries + 1
          vim.defer_fn(function()
            typescriptHandler(_, result, context)
          end, 100)
        else
          vim.notify("Could not find ts_ls required by vue_ls.", vim.log.levels.ERROR)
        end
        return
      end
      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward",
        command = "typescript.tsserverRequest",
        arguments = { command, payload },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r and r.body } }
        client:notify("tsserver/response", response_data)
      end)
    end
    client.handlers["tsserver/request"] = typescriptHandler
  end,
  init_options = {
    typescript = {
      tsdk = utils.getTypescriptPath(),
    },
  },
  settings = {
    vue = {
      format = {
        template = { initialIndent = true },
        script = { initialIndent = true },
        style = { initialIndent = true },
      },
    },
  },
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  root_markers = { "tsconfig.json", "tsconfig.js", "jsconfig.js", "jsconfig.json", "package.json", ".git" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
        configNamespace = "typescript",
      },
    },
  },
  settings = {
    diagnostics = {
      ignoredCodes = { 7016, 80001, 6133, 80006 },
    },
  },
})

vim.lsp.config("bashls", {
  capabilities = capabilities,
  filetypes = { "sh", "bash", "zsh" },
})

vim.lsp.enable({
  "bashls",
  "html",
  "eslint",
  "cssls",
  "lua_ls",
  "vue_ls",
  "ts_ls",
  "gopls",
  "jsonls",
  "dockerls",
  "taplo",
  "yamlls",
  "htmx",
})
