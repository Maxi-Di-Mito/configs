require("http_client").setup({
  default_env_file = ".env.json",
  request_timeout = 30000,
  split_direction = "right",
  create_keybindings = true,

  profiling = {
    enabled = true,
    show_in_response = true,
    detailed_metrics = true,
  },

  keybindings = {
    select_env_file = "<leader>rf",
    set_env = "<leader>re",
    run_request = "<leader>rr",
    stop_request = "<leader>rx",
    toggle_verbose = "<leader>rv",
    toggle_profiling = "<leader>rp",
    dry_run = "<leader>rd",
    copy_curl = "<leader>rc",
    save_response = "<leader>rs",
  },
})

local wk = require("which-key")
wk.add({
  { "<leader>r", group = "REST" },
})
