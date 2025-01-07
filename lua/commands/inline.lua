vim.ui.input({ prompt = "Enter command to send to model", expand = true }, function(cmd)
	if cmd == "" or cmd == nil then
		return
	end

	local commentstring = require("terminal.utils.comment").commentstring

	cmd = commentstring() .. " AI!: " .. cmd

	require("terminal.utils.selection").insert_text(cmd)
end)
