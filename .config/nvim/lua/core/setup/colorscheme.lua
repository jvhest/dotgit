local settings = require("core.settings")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. settings.theme)
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. "darkplus")
if not status_ok then
	return
end
