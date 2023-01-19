local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("core.setup.lsp.mason")
-- require("core.setup.lsp.handlers").setup()
require("core.setup.lsp.diagnostics").setup()
require("core.setup.lsp.null-ls")

-- show diagnostics for current line in last line of window
local diagGrp = vim.api.nvim_create_augroup("CursorDiagnostics", { clear = true })
vim.api.nvim_create_autocmd("CursorMoved", {
	pattern = "*.py,*.lua,*.sh,*.rs,*.go",
	command = ":lua require('core.setup.lsp.diagnostics').echo_diagnostic()",
	group = diagGrp,
})

-- vim: ts=2 sts=2 sw=2 et
