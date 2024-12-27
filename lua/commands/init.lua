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
			require("commands.send").setup()
		elseif args.args == "toggle" then
			require("commands.toggle").setup()
		elseif args.args == "rewrite" then
			require("commands.rewrite").setup()
		elseif args.args == "ask" then
			require("commands.ask").setup()
		elseif args.args == "send_selection" then
			require("commands.send_selection").setup()
		elseif args.args == "file_picker" then
			require("commands.file_picker").setup()
		elseif args.args == "inline" then
			require("commands.inline").setup()
		end
	end, {
		nargs = 1,
		range = true,
		desc = "Aidrun main entry point",
		complete = function(ArgLead, CmdLine, CursorPos)
			return { "send", "toggle", "rewrite", "ask", "send_selection", "file_picker" }
		end,
	})
end
return M
