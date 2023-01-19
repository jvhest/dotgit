local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		-- Bash
		formatting.prettier.with({
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		-- Shell
		formatting.shfmt,
		diagnostics.shellcheck,
		-- Lua
		formatting.stylua,
		diagnostics.luacheck,
		-- Python
		formatting.black.with({
			extra_args = { "--fast", "-l 110" },
		}),
		diagnostics.flake8.with({
			extra_args = { "--max-line-length=110" },
		}),
		diagnostics.mypy,
	},
	on_attach = function(client, bufnr)
		-- format on save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = lsp_formatting, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = lsp_formatting,
				buffer = bufnr,
				callback = function()
					if client.name == "null-ls" then
						vim.lsp.buf.format({
							bufnr = bufnr,
						})
					end
				end,
			})
		end
	end,
})

-- vim: ts=2 sts=2 sw=2 et
