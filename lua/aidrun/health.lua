local M = {}

M.check = function()
	local health = vim.health
	health.start("Aidrun")
	-- Check if the terminal module is loaded
	local aider_ok = vim.fn.executable("aider")
	if aider_ok then
		health.ok("aider command found in PATH")
	else
		health.error("aider command not found in PATH")
	end

	local fzf_ok, fzf = pcall(require, "fzf-lua")
	local telescope_ok, telescope = pcall(require, "telescope")

	if not telescope_ok and not fzf_ok then
		health.error("Telescope or Fzf-lua not found")
	end
	if telescope_ok then
		health.ok("Telescope installed")
	end
	if fzf_ok then
		health.ok("Fzf-lua installed")
	end
end

return M
