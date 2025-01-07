local M = {}

--@param opts Config
M.invoke = function()
	local cmd = "Fix diagnostics "
	local fzf_ok, fzf = pcall(require, "fzf-lua")
	local telescope_ok, telescope = pcall(require, "telescope.builtin")

	if not fzf_ok and not telescope_ok then
		vim.notify("fzf-lua and telescope are not installed", vim.log.levels.ERROR)
	end

	local terminal = require("terminal")

	if fzf_ok then
		fzf.diagnostics_document({
			prompt = "Select diagnostics to send > ",
			file_icons = false,
			actions = {
				["default"] = function(selected)
					cmd = cmd .. selected[1]
					terminal.send_cmd(cmd .. "\r\n")
				end,
			},
		})
		return
	end

	if telescope_ok then
		local actions = require("telescope.actions")
		telescope.diagnostics({
			bufnr = 0,
			prompt_title = "Select diagnostics to send > ",
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<CR>", function()
					local selection = require("telescope.actions.state").get_selected_entry()
					cmd = cmd .. selection[1]
					terminal.send_cmd(cmd .. "\r\n")
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		return
	end
end

return M
