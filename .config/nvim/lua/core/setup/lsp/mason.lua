local servers = {
	"sumneko_lua",
	"pyright",
	"bashls",
}

-- Setup neovim lua configuration
require("neodev").setup()

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {
	on_attach = require("core.setup.lsp.handlers").on_attach,
	capabilities = require("core.setup.lsp.handlers").capabilities,
}

for _, server in pairs(servers) do
	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "core.setup.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

-- Turn on lsp status information
require("fidget").setup()

-- vim: ts=2 sts=2 sw=2 et
