local status_ok, neoTree = pcall(require, "neo-tree")
if not status_ok then
  return
end

-- neoTree.setup({
--   filesystem = {
--     filtered_items = {
--       -- hide_dotfiles = false
--     },
--   },
-- })
