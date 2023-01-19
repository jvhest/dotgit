-- Echoing of LSP diagnostics in the commandline.
local M = {}

M.setup = function()
	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = true, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- Location information about the last message printed.
local last_echo = { false, -1, -1 } -- The format is (did print, buffer number, line number).
local echo_timer = nil -- The timer used for displaying a diagnostic in the commandline.
local echo_timeout = 250 -- The timer after which to display a diagnostic in the commandline.
local warning_hlgroup = "WarningMsg" -- The highlight group to use for warning messages.
local error_hlgroup = "ErrorMsg" -- The highlight group to use for error messages.
local short_line_limit = 20 -- If first diagnostic line has fewer characters than this, add the second line to it.

-- Prints the first diagnostic for the current line.
function M.echo_diagnostic(opts, bufnr)
	if echo_timer then
		echo_timer:stop()
	end

	echo_timer = vim.defer_fn(function()
		bufnr = bufnr or 0

		local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1

		opts = opts or {
			lnum = line_nr,
			severity = { min = vim.diagnostic.severity.WARN },
		}

		if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line_nr then
			return
		end

		local line_diagnostics = vim.diagnostic.get(bufnr, opts)
		if vim.tbl_isempty(line_diagnostics) then
			-- If we previously echo'd a message, clear it out by echoing an empty message.
			if last_echo[1] then
				last_echo = { false, -1, -1 }
				vim.cmd('echo ""')
			end
			return
		end

		last_echo = { true, bufnr, line_nr }

		local diag = line_diagnostics[1]
		local width = vim.o.columns - 15
		local lines = vim.split(diag.message, "\n")
		local message = lines[1]

		if #lines > 1 and #message <= short_line_limit then
			message = message .. " " .. lines[2]
		end

		if width > 0 and #message >= width then
			message = message:sub(1, width) .. "..."
		end
		if #line_diagnostics > 1 then
			message = message .. " [" .. #line_diagnostics .. "]"
		end

		local kind = "W"
		local hlgroup = warning_hlgroup

		if diag.severity == vim.diagnostic.severity.ERROR then
			kind = "E"
			hlgroup = error_hlgroup
		end

		local chunks = {
			{ kind .. ": ", hlgroup },
			{ message },
		}

		vim.api.nvim_echo(chunks, false, {})
	end, echo_timeout)
end

return M

-- vim: ts=2 sts=2 sw=2 et
