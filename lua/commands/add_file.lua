local M = {}

--@param opts Config
M.setup = function()
	---@diagnostic disable-next-line: missing-fields
	local project_root = vim.fn.getcwd()
	local file_path = vim.fn.expand("%:p")
	local relative_path = string.sub(file_path, #project_root + 2)
	local cmd = "/add " .. relative_path .. "\r\n"
	local terminal = require("terminal")
	terminal.send_cmd(cmd)
end

return M
