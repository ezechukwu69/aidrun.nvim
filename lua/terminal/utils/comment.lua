local M = {}

local get_commentstring = function()
	local commentstring = vim.bo.commentstring

	-- Remove the %s placeholder from the commentstring
	return commentstring:gsub("%%s", "")
end

M.commentstring = get_commentstring

return M
