local M = {}

M.state = {
	buffer = -1,
}

local function has_visual_selection()
	-- Check if there is a range selected (using '< and '>')
	M.state.buffer = vim.api.nvim_get_current_buf()
	return vim.fn.getpos("'<")[2] ~= vim.fn.getpos("'>")[2] or vim.fn.getpos("'<")[3] ~= vim.fn.getpos("'>")[3]
end

M.get_visual_position = function()
	local mode = vim.fn.mode()
	if not has_visual_selection() then
		return nil -- Not in visual mode
	end

	-- Get the start and end positions of the selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Extract the lines and columns
	local start_line, start_col = start_pos[2], start_pos[3] - 1
	local end_line, end_col = end_pos[2], end_pos[3]

	-- Extract the lines and columns

	-- Adjust column for exclusive selection in charwise mode
	if vim.fn.mode() == "v" and start_line == end_line then
		end_col = end_col + 1
	end
	return start_line, start_col, end_line, end_col
end

M.get_visual_selection = function()
	-- local mode = vim.fn.visualmode()
	if not has_visual_selection() then
		return nil -- Not in visual mode
	end

	-- Get the start and end positions of the selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Extract the lines and columns
	local start_line, start_col = start_pos[2], start_pos[3]
	local end_line, end_col = end_pos[2], end_pos[3]

	-- Adjust column for exclusive selection in charwise mode
	if vim.fn.mode() == "v" and start_line == end_line then
		end_col = end_col + 1
	end

	-- Get the lines within the selection
	local lines = vim.api.nvim_buf_get_lines(M.state.buffer, start_line - 1, end_line, false)

	-- Extract the exact text from the lines
	if #lines == 0 then
		return nil -- No text selected
	elseif #lines == 1 then
		if start_col > end_col then
			start_col, end_col = end_col, start_col
		end
		return string.sub(lines[1], start_col, end_col - 1)
	else
		if start_col > end_col then
			start_col, end_col = end_col, start_col
		end
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col - 1)
		return table.concat(lines, "\n")
	end
end

local function split_string_by_newline(input)
	local result = {}
	for line in input:gmatch("([^\n]*)\n?") do
		table.insert(result, line)
	end
	return result
end

---@param start_line number
---@param end_line number
---@param joined_lines string
M.replace_selection = function(start_line, end_line, joined_lines)
	vim.api.nvim_buf_set_lines(M.state.buffer, start_line - 1, end_line, false, {})

	-- Exit visual mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

	local lines = split_string_by_newline(joined_lines)

	vim.api.nvim_buf_set_lines(M.state.buffer, start_line - 1, start_line - 1, false, lines)
	vim.cmd("w")
end

local function contains_non_whitespace(str)
	return string.find(str, "%S") ~= nil
end

---@param text string
M.insert_text = function(text)
	-- get current line number
	local line_num = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	if contains_non_whitespace(line) then
		vim.api.nvim_buf_set_lines(0, line_num, line_num, false, { text })
	else
		vim.api.nvim_set_current_line(text)
	end
end

return M
