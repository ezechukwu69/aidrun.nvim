local M = {}

M.setup = function()
	local fzf_ok, fzf = pcall(require, "fzf-lua")
	local telescope_ok, telescope = pcall(require, "telescope.builtin")

	if not fzf_ok and not telescope_ok then
		vim.notify("fzf-lua and telescope are not installed", vim.log.levels.ERROR)
	end

	local terminal = require("terminal")

	if fzf_ok then
		fzf.files({
			prompt = "Select a file to add",
			file_icons = false,
			-- cwd = vim.fn.expand("%:p:h"),
			actions = {
				["default"] = function(selected)
					print(vim.inspect(selected[1]))
					local cmd = "/add " .. selected[1]
					terminal.send_cmd(cmd .. "\r\n")
				end,
			},
		})
	end

	if not fzf_ok and telescope_ok then
		local actions = require("telescope.actions")
		telescope.find_files({
			prompt_title = "Select a file to add",
			-- cwd = vim.fn.expand("%:p:h"),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<CR>", function()
					local selection = require("telescope.actions.state").get_selected_entry()

					-- local cwd = vim.fn.expand("%:p:h")
					--
					-- -- Convert the selected file path to relative path
					-- local relative_path = vim.fn.fnamemodify(selection[1], ":~" .. cwd)
					local cmd = "/add " .. selection[1]
					terminal.send_cmd(cmd .. "\r\n")
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
	end
end

return M