local null_ls_status_ok, gitsigns = pcall(require, "gitsigns")
if not null_ls_status_ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- vim: ts=2 sts=2 sw=2 et
