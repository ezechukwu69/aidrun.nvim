local selection = require("terminal.utils.selection").get_visual_selection()

if selection == nil then
	vim.notify("No selection found", vim.log.levels.ERROR)
	return
end

vim.ui.input({ prompt = "Enter command to send to terminal", expand = true }, function(cmd)
	if cmd == "" or cmd == nil then
		return
	end

	cmd = cmd .. "\n" .. selection

	vim.notify(cmd)
	cmd = cmd .. "\r\n"

	local terminal = require("terminal")
	terminal.send_cmd(cmd)
end)
