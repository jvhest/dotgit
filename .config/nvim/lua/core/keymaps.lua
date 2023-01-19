local M = {}

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

--
-- GENERAL NORMAL-MODE

local nmap = vim.fn["my#get_keymap_func"]("GENERAL", "n", { noremap = true, silent = true })

-- Normal --
-- delete single character without copying into register
nmap("x", '"_x', "Delete character without copying into register")

-- play macro in q register
nmap("<S-q>", "@q", "Play macro in q register")

-- Increment/decrement numbers
nmap("<leader>+", "<C-a>", "Increment number")
nmap("<leader>-", "<C-x>", "Decrement number")

-- Shortcuts
nmap("<leader>h", "^", "Jump start of line")
nmap("<leader>l", "g_", "Jump en of line")

nmap("<leader>a", ":keepjumps normal! ggVG<cr>", "????")

nmap("<esc>", "<cmd>nohlsearch<CR>", "No Highlite")
nmap("<leader>Q", "<cmd>bufdo bdelete<CR>", "Close ALL buffers")
nmap("<leader>D", "<cmd>%bd|e#|bd#<cr>", "Close ALL but CURRENT")
nmap("<leader>d", "<cmd>bdelete!<CR>", "Close current buffer")
nmap("q:", ":q<CR>", "Correct typo")

-- Window management
nmap("<leader>wv", "<C-w>v", "Split window vertically")
nmap("<leader>wh", "<C-w>s", "Split window horizontally")
nmap("<leader>we", "<C-w>=", "Make split windows equal width & height")
nmap("<leader>wx", ":close<CR>", "Close current split window")

-- keymap("n", "T", "mzJ`z") ???
nmap("<C-d>", "<C-d>zz", "Page down center cursor")
nmap("<C-u>", "<C-u>zz", "Page up center cursor")
nmap("n", "nzzzv", "Next selection center cursor")
nmap("N", "Nzzzv", "Prev selection center cursor")

-- Better window navigation
nmap("<C-h>", "<C-w>h", "Window left")
nmap("<C-j>", "<C-w>j", "Window down")
nmap("<C-k>", "<C-w>k", "Window up")
nmap("<C-l>", "<C-w>l", "Window right")

-- Better window navigation (C-hjkl)
-- zie plugin: christoomey/vim-tmux-navigator  -- tmux & split window navigation

-- Resize with arrows
nmap("<C-Up>", ":resize -2<CR>", "Resize window up")
nmap("<C-Down>", ":resize +2<CR>", "Resize window down")
nmap("<C-Left>", ":vertical resize -2<CR>", "Resize window left")
nmap("<C-Right>", ":vertical resize +2<CR>", "Resize window right")

-- Navigate buffers
nmap("<S-l>", "<cmd>bnext<CR>", "Buffer left")
nmap("<S-h>", "<cmd>bprevious<CR>", "Buffer right")
nmap("<leader><tab>", "<cmd>e#<CR>", "Prev buffer")

-- Move text up and down
nmap("<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")
nmap("<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")

nmap("<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment line(s)")

nmap("<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Open terminal horizontal")
nmap("<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Open terminal vertical")
nmap("<leader>tt", "<cmd>ToggleTerm<cr>", "Toggle terminal")

-- Remap for dealing with word wrap
nmap("k", "v:count == 0 ? 'gk' : 'k'", "Word wrap ???", { expr = true, silent = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", "Wordwrap ???", { expr = true, silent = true })

nmap("<leader>md", "<cmd>MarkdownPreview<CR>", "Open browser with Markdown file")

--
-- GENERAL: VISUAL-MODE

local vmap = vim.fn["my#get_keymap_func"]("GENERAL", "v", { noremap = true, silent = true })

-- Paste replace visual selection without copying it
vmap("p", '"_dP', "Paste replace visual selection without copying it")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vmap("y", "myy`y", "Maintain the cursor position when yanking")
vmap("Y", "myY`y", "Maintain the cursor position when yanking")

vmap("<", "<gv", "Stay in indent mode")
vmap(">", ">gv", "Stay in indent mode")

-- Move text up and down
vmap("<A-j>", ":m .+1<CR>==", "Move selected text down")
vmap("<A-k>", ":m .-2<CR>==", "Move selected text up")

--
-- GENERAL INSERT-MODE

local imap = vim.fn["my#get_keymap_func"]("GENERAL", "i", { noremap = true, silent = true })

-- Easy insertion of a trailing ; or , from insert mode
imap(";;", "<Esc>A;<Esc>", "Easy insertion trailing ; or ,")
imap(",,", "<Esc>A,<Esc>", "Easy insertion trailing ; or ,")

-- Press jk fast to exit insert-mode
imap("jk", "<ESC>", "Exit insert-mode")
imap("kj", "<ESC>", "Exit insert-mode")

--
-- GENERAL VISUAL BLOCK-MODE

local xmap = vim.fn["my#get_keymap_func"]("GENERAL", "x", { noremap = true, silent = true })

-- Move text up and down
xmap("<A-j>", ":move '>+1<CR>gv-gv", "Move selected Block down")
xmap("<A-k>", ":move '<-2<CR>gv-gv", "Move selected Block up")
xmap(
	"<leader>/",
	'<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
	"Comment visual Block"
)

-- GENERAL TERMINAL-MODE

local tmap = vim.fn["my#get_keymap_func"]("GENERAL", "t", { silent = true })
-- Better terminal navigation
tmap("<C-h>", "<C-\\><C-N><C-w>h", "From terminal to window left")
tmap("<C-j>", "<C-\\><C-N><C-w>j", "From terminal to window down")
tmap("<C-k>", "<C-\\><C-N><C-w>k", "From terminal to window up")
tmap("<C-l>", "<C-\\><C-N><C-w>l", "From terminal to window right")

--
------------------------------------------------------------------------------
-- TELESCOOP KEYMAPS
------------------------------------------------------------------------------
M.telescope_keymaps = function()
	-- TELESCOPE KEYMAPS
	-- See `:help telescope.builtin`

	nmap = vim.fn["my#get_keymap_func"]("TELESCOPE", "n", { noremap = true })

	local builtin = require("telescope.builtin")
	nmap("<leader>o", builtin.oldfiles, "[?] Find recently opened files")

	nmap("<leader>ff", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, "[F]uzzily [F]ind in current buffer")

	nmap("<leader>F", function()
		builtin.find_files(require("telescope.themes").get_dropdown({
			previewer = false,
		}))
	end, "[S]earch [F]iles")

	nmap("<leader>f", "<cmd>Telescope file_browser<cr>", "[F]ile [B]rowser")

	nmap("<leader><leader>", function()
		builtin.buffers(require("telescope.themes").get_dropdown({
			previewer = false,
		}))
	end, "[F]ind existing [B]uffer")

	nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles preview")
	nmap("<leader>sb", builtin.buffers, "[F]ind existing [B]uffer preview")
	nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
	nmap("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
	nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
	nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")

	-- find project
	nmap("<leader>sp", function()
		require("telescope").extensions.projects.projects()
	end, "[F]ind [P]roject")
end

--
------------------------------------------------------------------------------
-- LSP KEYMAPS
------------------------------------------------------------------------------
M.lsp_keymaps = function(bufnr)
	nmap = vim.fn["my#get_keymap_func"]("LSP", "n", {}, bufnr)

	-- Diagnostic keymaps
	nmap("[d", vim.diagnostic.goto_prev, "[P]rev [D]iagnostic")
	nmap("]d", vim.diagnostic.goto_next, "[N]ext [D]iagnostic")
	nmap("<leader>e", vim.diagnostic.open_float, "[F]loat [D]iagnostics")
	nmap("<leader>q", vim.diagnostic.setloclist, "[Q]uickfix")

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "[T]ype [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

return M

-- vim: ts=2 sts=2 sw=2 et
