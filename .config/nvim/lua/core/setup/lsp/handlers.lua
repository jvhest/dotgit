local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.on_attach = function(client, bufnr)
	-- exclude server capabilities that are delivered by null-ls
	local servers_to_exclude_for_format = {
		"sumneko_lua",
		"pyright",
		"bashls",
	}
	for _, server_name in ipairs(servers_to_exclude_for_format) do
		if client.name == server_name then
			client.server_capabilities.documentFormattingProvider = false
		end
	end

	-- load lsp keymaps
	require("core.keymaps").lsp_keymaps(bufnr)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M

-- vim: ts=2 sts=2 sw=2 et
