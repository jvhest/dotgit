local f = require("core.utils.functions")

vim.fn["my#trim_trailing_spaces"] = f.trim_trailing_spaces

vim.fn["my#block_messages"] = f.block_messages

vim.fn["my#set_keymap"] = f.set_keymap

vim.fn["my#get_keymap_func"] = f.get_keymap_func

vim.fn["my#persist_select"] = f.persist_select

-- vim: ts=2 sts=2 sw=2 et
