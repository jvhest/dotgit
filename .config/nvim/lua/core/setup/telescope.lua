-- See `:help telescope` and `:help telescope.setup()`
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end
-- local settings = require("core.settings")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local fb_actions = telescope.extensions.file_browser.actions
local icons = require("core.utils.icons")

-- require('telescope').setup {
telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case" or "smart_case"
		},

		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			-- theme = "ivy",
			-- require("telescope.themes").get_dropdown {
			--   previewer = false,
			--   -- even more opts
			-- },
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					["<c-n>"] = fb_actions.create,
					["<c-r>"] = fb_actions.rename,
					["<c-h>"] = fb_actions.toggle_hidden,
					["<c-x>"] = fb_actions.remove,
					["<c-p>"] = fb_actions.move,
					["<c-y>"] = fb_actions.copy,
					["<c-a>"] = fb_actions.select_all,
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},

	pickers = {
		-- Default configuration for builtin pickers goes here:
		find_files = {
			hidden = false,
		},
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
		},
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},

	defaults = {
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

				["<c-s>"] = action_layout.toggle_preview,

				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
		file_ignore_patterns = { "__pycache__", "node_modules", ".terraform", "%.jpg", "%.png" },
		prompt_prefix = table.concat({ icons.arrows.ChevronRight, "" }),
		-- selection_caret = icons.arrows.SmallArrowRight,
		multi_icon = icons.arrows.Diamond,
		path_display = { "smart" },
		entry_prefix = "  ",
		initial_mode = "insert",
		scroll_strategy = "cycle",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "vertical",
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

-- load telescope keymaps
require("core.keymaps").telescope_keymaps()

-- vim: ts=2 sts=2 sw=2 et
