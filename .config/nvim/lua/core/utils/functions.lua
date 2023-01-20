local settings = require("core.settings")

local M = {}

M.trim_trailing_spaces = function()
	local ftype = vim.filetype.match({ buf = 0 })
	for _, ft in ipairs(settings.whitespace_ignored_filetypes) do
		if ft == ftype then
			return nil
		end
	end
	vim.cmd([[%s/\s\+$//e]])
end

M.block_messages = function(search_text)
	local orig_notify = vim.notify

	local filter_notify = function(text, level, opts)
		if type(text) == "string" and string.find(text, search_text, 1, true) then
			return
		end

		orig_notify(text, level, opts)
	end

	vim.notify = filter_notify
end

M.set_keymap = function(bufnr)
	return function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
end

M.get_keymap_func = function(group, mode, opts, bufnr)
	if bufnr then
		opts.buffer = bufnr
	end

	return function(keys, func, desc, other_opts)
		if desc then
			desc = group .. ": " .. desc
			opts.desc = desc
		end

		other_opts = other_opts or opts
		vim.keymap.set(mode, keys, func, other_opts)
	end
end

M.persist_select = function(prompt_bufnr)
	require("telescope.actions").select_default(prompt_bufnr)
	require("telescope.builtin").resume()
end

-- ---------------------------------------------------
-- example functions
-- ---------------------------------------------------

M.notify = function(message, level, title)
	local notify_options = {
		title = title,
		timeout = 2000,
	}
	vim.api.nvim_notify(message, level, notify_options)
end

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
	return s ~= nil and s ~= ""
end

--- Check if path exists
M.path_exists = function(path)
	local ok = vim.loop.fs_stat(path)
	return ok
end

-- Return telescope files command
M.telescope_find_files = function()
	local path = vim.loop.cwd() .. "/.git"
	if M.path_exists(path) then
		return "Telescope git_files"
	else
		return "Telescope find_files"
	end
end

-- toggle quickfixlist
M.toggle_qf = function()
	local windows = vim.fn.getwininfo()
	local qf_exists = false
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd([[ cclose ]])
		return
	end
	if M.isNotEmpty(vim.fn.getqflist()) then
		vim.cmd([[ copen ]])
	end
end

-- toggle colorcolumn
M.toggle_colorcolumn = function()
	local value = vim.api.nvim_get_option_value("colorcolumn", {})
	if value == "" then
		M.notify("Enable colocolumn", 1, "functions.lua")
		vim.api.nvim_set_option_value("colorcolumn", "79", {})
	else
		M.notify("Disable colocolumn", 1, "functions.lua")
		vim.api.nvim_set_option_value("colorcolumn", "", {})
	end
end

-- move over a closing element in insert mode
M.escapePair = function()
	local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
	local line = vim.api.nvim_get_current_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local after = line:sub(col + 1, -1)
	local closer_col = #after + 1
	local closer_i = nil
	for i, closer in ipairs(closers) do
		local cur_index, _ = after:find(closer)
		if cur_index and (cur_index < closer_col) then
			closer_col = cur_index
			closer_i = i
		end
	end
	if closer_i then
		vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
	else
		vim.api.nvim_win_set_cursor(0, { row, col + 1 })
	end
end

-- returns the require for use in `config` parameter of packer's `use`
-- expects the name of the config file
-- prefixes with `core.config.`
M.get_config = function(name)
	return string.format('require("core.config.%s")', name)
end

return M

-- vim: ts=2 sts=2 sw=2 et
