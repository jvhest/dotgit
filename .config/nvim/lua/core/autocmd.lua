local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ----------------------------------------------
-- Trailing whitespace
-- ----------------------------------------------

--- Remove/Highlight all trailing whitespace on save
local trimWhiteSpaceGrp = augroup("TrimWhiteSpace", { clear = true })
autocmd(
	{ "VimEnter", "WinEnter" },
	{ pattern = "*", command = [[highlight ExtraWhitespace ctermbg=darkred guibg=darkred]], group = trimWhiteSpaceGrp }
)
autocmd(
	{ "VimEnter", "WinEnter" },
	{ pattern = "*", command = [[match ExtraWhitespace /\s\+$/]], group = trimWhiteSpaceGrp }
)
-- trim trailing spaces
autocmd("BufWritePre", {
	callback = vim.fn["my#trim_trailing_spaces"],
	group = trimWhiteSpaceGrp,
})

-- Highlight on yank
local yankGrp = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = yankGrp,
})

-- windows to close with "q"
local quickCloseGrp = augroup("QuickClose", { clear = true })
autocmd("FileType", {
	pattern = { "help", "startuptime", "qf", "fugitive", "null-ls-info", "dap-float" },
	command = [[nnoremap <buffer><silent> q :close<CR>]],
	group = quickCloseGrp,
})
autocmd("FileType", {
	pattern = "man",
	command = [[ nnoremap <buffer><silent> q :quit<CR> ]],
	group = quickCloseGrp,
})

-- show cursor line only in active window
-- local cursorGrp = augroup("CursorLine", { clear = true })
-- autocmd({ "WinEnter" }, {
-- 	pattern = "*",
-- 	command = [[ set cursorline | set cursorcolumn ]],
-- 	group = cursorGrp,
-- })
-- autocmd({ "WinLeave" }, {
-- 	pattern = "*",
-- 	command = [[ set nocursorline | set nocursorcolumn ]],
-- 	group = cursorGrp,
-- })

local generalGrp = augroup("General", { clear = true })
-- don't auto comment new line
autocmd("BufEnter", {
	command = [[set formatoptions-=cro]],
	group = generalGrp,
})

-- wrap words "softly" (no carriage return) in mail buffer
autocmd("Filetype", {
	pattern = "mail",
	callback = function()
		vim.o.textwidth = 0
		vim.o.wrapmargin = 0
		vim.o.wrap = true
		vim.o.linebreak = true
		vim.o.columns = 80
		vim.o.colorcolumn = "80"
	end,
	group = generalGrp,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
	group = generalGrp,
})

-- Enable spell checking for certain file types
-- autocmd( { "BufRead", "BufNewFile" }, {
--   pattern = { "*.txt", "*.md", "*.tex" },
--   callback = function()
--     vim.o.spell = true
--     vim.o.spelllang = "en,nl"
--   end,
--   group = generalGrp,
-- })

-- vim: ts=2 sts=2 sw=2 et
