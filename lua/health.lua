local M = {}

M.check = function()
	local ok = true
	local errors = {}

	-- Check if the terminal module is loaded
	local terminal_ok, terminal_err = pcall(require, "terminal")
	if not terminal_ok then
		ok = false
		table.insert(errors, "terminal module not loaded: " .. terminal_err)
	end

	-- Check if the aider command is available
	local aider_ok = vim.fn.executable("aider")
	if not aider_ok then
		ok = false
		table.insert(errors, "aider command not found in PATH")
	end

	-- Check if the config module is loaded
	local config_ok, config_err = pcall(require, "config")
	if not config_ok then
		ok = false
		table.insert(errors, "config module not loaded: " .. config_err)
	end

	if ok then
		return {
			ok = true,
			msg = "Plugin is healthy",
		}
	else
		return {
			ok = false,
			msg = "Plugin has errors:\n" .. table.concat(errors, "\n"),
		}
	end
end

return M
