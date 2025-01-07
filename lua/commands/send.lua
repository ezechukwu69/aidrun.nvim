vim.ui.input({ prompt = "Enter command to send to terminal", expand = true }, function(cmd)
	if cmd == "" then
		return
	end
	local terminal = require("terminal")
	terminal.send_cmd(cmd)
end)
