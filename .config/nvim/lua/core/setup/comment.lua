local status_ok, Comment = pcall(require, "Comment")
if not status_ok then
	return
end

Comment.setup()

-- vim: ts=2 sts=2 sw=2 et
