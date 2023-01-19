local M = {}

-- theme: onedark, tokyonight, gruvbox-material, darkplus, palenight
M.theme = "darkplus"
-- filetype that dont need trimming trailing spaces
M.whitespace_ignored_filetypes = { "markdown" }
-- use rg instead of grep
M.grepprg = "rg --hidden --vimgrep --smart-case --"
-- treesitter parsers to be installed
-- one of "all", "maintained" (parsers with maintainers), or a list of languages
M.treesitter_ensure_installed = {
	"bash",
	"cmake",
	"css",
	"dockerfile",
	"go",
	"hcl",
	"html",
	"java",
	"javascript",
	"json",
	"kotlin",
	"ledger",
	"lua",
	"markdown",
	"markdown_inline",
	"query",
	"python",
	"regex",
	"toml",
	"vim",
	"yaml",
}

return M
