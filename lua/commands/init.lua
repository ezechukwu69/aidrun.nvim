local M = {}

vim.g.aiderun_id = nil

local cmd = vim.api.nvim_create_user_command

-- Example keymaps
-- local keymap = vim.keymap.set
-- keymap("n", "<space>us", ":Aidrun send<CR>", { desc = "Aidrun send" })
-- keymap("n", "<space>ut", ":Aidrun toggle<CR>", { desc = "Aidrun toggle" })
-- keymap({ "n", "v" }, "<space>ur", ":Aidrun rewrite<CR>", { desc = "Aidrun rewrite" })
-- keymap({ "n", "v" }, "<space>ua", ":Aidrun ask<CR>", { desc = "Aidrun ask" })
-- keymap({ "n", "v" }, "<space>ux", ":Aidrun send_selection<CR>", { desc = "Aidrun send_selection" })
-- keymap("n", "<space>uf", ":Aidrun file_picker<CR>", { desc = "Aidrun file_picker" })
-- keymap("n", "<space>ui", ":Aidrun inline<CR>", { desc = "Aidrun inline" })

---@param opts Config
function M.setup(opts)
	cmd("Aidrun", function(args)
		require("terminal").setConfig(opts)
		if args.args == "send" then
			require("commands.send")
		elseif args.args == "toggle" then
			require("commands.toggle")
		elseif args.args == "rewrite" then
			require("commands.rewrite")
		elseif args.args == "ask" then
			require("commands.ask")
		elseif args.args == "send_selection" then
			require("commands.send_selection")
		elseif args.args == "file_picker" then
			require("commands.file_picker")
		elseif args.args == "inline" then
			require("commands.inline")
		elseif args.args == "workspace_diagnostics" then
			require("commands.workspace_diagnostics")
		elseif args.args == "file_diagnostics" then
			require("commands.file_diagnostics").setup()
		elseif args.args == "add_file" then
			require("commands.add_file")
		elseif args.args == "commit" then
			require("commands.commit")
		elseif args.args == "web" then
			require("commands.web")
		elseif args.args == "paste" then
			require("commands.paste")
		elseif args.args == "clear" then
			require("commands.clear")
		end
	end, {
		nargs = 1,
		range = true,
		desc = "Aidrun main entry point",
		complete = function(ArgLead, CmdLine, CursorPos)
			return {
				"send",
				"toggle",
				"rewrite",
				"ask",
				"clear",
				"paste",
				"send_selection",
				"file_picker",
				"workspace_diagnostics",
				"file_diagnostics",
				"add_file",
				"inline",
				"commit",
				"web",
			}
		end,
	})
end

return M
