local M = {}

local get_commentstring = function()
	local commentstring = vim.bo.commentstring

	-- Remove the %s placeholder from the commentstring
	commentstring = commentstring:gsub("%%s", "")

	-- Ensure the comment string does not close prematurely
	return commentstring
end

M.commentstring = get_commentstring

return M
