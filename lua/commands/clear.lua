local M = {}

M.invoke = function()
	local cmd = "/clear"
	local terminal = require("terminal")
	terminal.send_cmd(cmd)
end

return M
