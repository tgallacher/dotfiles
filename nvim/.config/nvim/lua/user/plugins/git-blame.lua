local status_ok, gitblame = pcall(require, "gitblame")
if not status_ok then
  vim.notify "Failed to load gitblame plugin.."
  return
end

gitblame.setup({
  enabled = false, -- use keymap to view blame
})
