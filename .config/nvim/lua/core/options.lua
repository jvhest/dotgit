-- See `:help vim.o`

-- line numbers
vim.o.number = true -- set numbered lines
vim.o.numberwidth = 4 -- set number column width to 2 {default 4}
vim.o.relativenumber = true -- set relative numbered lines

-- tabs and indents
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.smartindent = true -- make indenting smarter again
vim.o.expandtab = true -- convert tabs to spaces
vim.o.autoindent = true

-- line wrapping
vim.o.wrap = true -- display lines as one long line
vim.o.linebreak = true -- companion to wrap, don't split words

-- search settings
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.smartcase = true -- smart case
vim.o.hlsearch = true -- highlight all matches on previous search pattern

-- cursor line/column highlight
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- appearance
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.background = "dark"
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.showtabline = 0 -- always show tabs
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.showcmd = false -- hide (partial) command in last line of screen
vim.o.ruler = false -- hide line and column number of cursor
vim.o.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.o.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
vim.o.pumheight = 10 -- pop up menu height
vim.o.list = false
vim.o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<" -- which list chars to schow

-- backspace
vim.o.backspace = "indent,eol,start"

-- clipboard
vim.o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- split windows
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window

-- backup, undo, swap
vim.o.backup = false -- creates a backup file
vim.o.undofile = true -- enable persistent undo
vim.o.undodir = vim.env.HOME .. "/.vim/undodir"
vim.o.swapfile = false -- creates a swapfile

vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.mouse = "a" -- allow the mouse to be used in neovim
vim.o.timeoutlen = 800 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.updatetime = 250 -- faster completion (4000ms default)
vim.o.writebackup = false -- if file is being edited by another program it is not allowed to be edited
vim.o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
-- o.guicursor = "n-v-c:block,i-ci-ve:hor25,r-cr:hor20,o:hor50" -- block in normal and beam cursor in insert mode
vim.o.breakindent = true -- Enable break indent

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth',
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

-- vim: ts=2 sts=2 sw=2 et
