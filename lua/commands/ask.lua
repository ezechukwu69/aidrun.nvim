local selection = require("terminal.utils.selection").get_visual_selection()

if selection == nil then
	vim.notify("No selection found", vim.log.levels.ERROR)
	return
end

vim.ui.input({ prompt = "Enter command to send to terminal", expand = true }, function(cmd)
	if cmd == "" or cmd == nil then
		return
	end

	local commentstring = require("terminal.utils.comment").commentstring

	cmd = commentstring() .. " AI?: " .. cmd .. "\n" .. selection .. "\n" .. commentstring() .. "AI?"

	vim.notify(cmd)

	local start_line, start_col, end_line, end_col = require("terminal.utils.selection").get_visual_position()
	require("terminal.utils.selection").replace_selection(start_line, end_line, cmd)
end)
