local M = {}

M.invoke = function()
	vim.ui.input({ prompt = "Enter url to scrape", expand = true }, function(cmd)
		if cmd == "" then
			return
		end
		cmd = "/web " .. cmd
		local terminal = require("terminal")
		terminal.send_cmd(cmd)
	end)
end

return M
