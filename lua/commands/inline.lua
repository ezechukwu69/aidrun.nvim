---@diagnostic disable: unused-local
local M = {}

function M.setup()
	vim.ui.input({ prompt = "Enter command to send to terminal", expand = true }, function(cmd)
		if cmd == "" or cmd == nil then
			return
		end

		local commentstring = require("terminal.utils.comment").commentstring

		cmd = commentstring() .. " AI!: " .. cmd

		require("terminal.utils.selection").insert_text(cmd)
	end)
end

return M
