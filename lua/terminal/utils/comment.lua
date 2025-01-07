local M = {}

local get_commentstring = function()
	local commentstring = vim.bo.commentstring

	-- Remove the %s placeholder from the commentstring
	commentstring = commentstring:gsub("%%s", "")

	-- Ensure the comment string does not close prematurely
	local first_char = commentstring:sub(1, 1)
	local last_char = commentstring:sub(-1)
	if first_char == last_char then
		commentstring = first_char
	end

	return commentstring
end

M.commentstring = get_commentstring

return M
