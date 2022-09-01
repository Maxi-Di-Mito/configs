lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()
  -- local components = require "lvim.core.lualine.components"

  -- remove lsp servers list
  table.remove(config.sections.lualine_x, 3)

  -- add relative path to filename
  table.remove(config.sections.lualine_b, 2)
  table.insert(config.sections.lualine_b, 2, {
    'filename',
    file_status = true,
    path = 1
  })

  -- add relative path to filename to inactive_sections
  table.remove(config.inactive_sections.lualine_a, 1)
  table.insert(config.inactive_sections.lualine_a, 1, {
    'filename',
    file_status = true,
    path = 1
  })
  lualine.setup(config)
end
