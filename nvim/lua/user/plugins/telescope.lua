return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    -- local previewers = require("telescope.previewers")
    -- local pickers = require("telescope.pickers")
    -- local sorters = require("telescope.sorters")
    -- local finders = require("telescope.finders")

    -- local customBufferCommits = pickers.new({
    --   results_title = "Commits",
    --   finder = finders.new_oneshot_job({ "git" }),
    -- })

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>f", function()
      builtin.find_files({ hidden = true, ignore = true })
    end, { desc = "Find files" })
    keymap.set("n", "<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find current buffers" })
    keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "Find buffer's commits" })
    keymap.set("n", "go", builtin.git_status, { desc = "Git status files" })
    -- keymap.set("v", "<leader>gc", builtin.git_bcommits_range, { desc = "Find current lines commits" })

    keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "File symbols" })
  end,
}
