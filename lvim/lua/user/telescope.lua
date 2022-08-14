-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.active = false
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "node_modules"
}

lvim.builtin.telescope.extensions = {
  "ag"
}

-- change git_files call to include untracked
lvim.builtin.which_key.mappings["f"] = { "<cmd>lua require'telescope.builtin'.git_files({show_untracked = true})<cr>",
  "Git Files" }

-- lvim.builtin.which_key.mappings["s"]["t"] = { "<cmd>lua require'telescope'.extensions.ag.search()<cr>", "Text" }
