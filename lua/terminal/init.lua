---@class Terminal
---@field terminal_id integer
---@field terminal_bufnr integer
---@field terminal_winid integer
---@field config? Config
---@field esc_timer? uv_timer
---@field command? string
local M = {}

local state = {
	terminal_id = nil,
	terminal_bufnr = -1,
	terminal_winid = -1,
	config = nil,
}

M.state = state

---@param config Config
M.setConfig = function(config)
	if not config then
		return
	end
	state.config = config
end

M.create_terminal = function()
	state.command = M.create_command(state.config)
	---@type number
	local buf
	if state.terminal_bufnr ~= -1 and vim.api.nvim_buf_is_valid(state.terminal_bufnr) then
		buf = state.terminal_bufnr
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Open a right vertical split
	vim.cmd("rightbelow vsplit")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)

	-- Optionally set window size
	local width = math.floor(vim.o.columns * (state.config.width or 0.35))
	vim.api.nvim_win_set_width(win, width)

	-- Map <esc><esc> to stop insert mode
	vim.keymap.set({ "x", "t" }, "<esc><esc>", function()
		vim.cmd("stopinsert")
	end, { buffer = buf, nowait = true })

	state.terminal_bufnr = buf
	state.terminal_winid = win

	vim.wo[state.terminal_winid].number = false
	vim.wo[state.terminal_winid].relativenumber = false

	---@type number
	if vim.bo[state.terminal_bufnr].buftype ~= "terminal" then
		-- Open the terminal and start the command
		vim.cmd.terminal(state.command)
		vim.bo[buf].buflisted = false
	end

	-- detect when program running in terminal ends so we can close the terminal
	vim.api.nvim_create_autocmd("TermClose", {
		once = true,
		buffer = buf,
		callback = function()
			M.close_terminal()
		end,
	})

	state.terminal_id = vim.bo.channel
	vim.cmd.startinsert()
end

--- call create terminal if the terminal_id is nil or window is not valid or buffer is not valid
--- @return boolean
local function create_terminal()
	if
		state.terminal_id == nil
		or not vim.api.nvim_win_is_valid(state.terminal_winid)
		or not vim.api.nvim_buf_is_valid(state.terminal_bufnr)
	then
		M.create_terminal()
		return true
	else
		return false
	end
end

M.close_terminal = function()
	state.terminal_id = nil
	vim.api.nvim_buf_delete(state.terminal_bufnr, { force = true })
	vim.api.nvim_win_close(state.terminal_winid, true)
end

M.toggle_terminal = function()
	if state.terminal_winid ~= -1 and vim.api.nvim_win_is_valid(state.terminal_winid) then
		print("hiding terminal")
		vim.api.nvim_win_hide(state.terminal_winid)
	else
		print("showing terminal")
		M.create_terminal()
	end
end

---@param cmd string
M.send_cmd = function(cmd)
	local created_newly = create_terminal()

	local send = function()
		if cmd == "" or cmd == nil then
			return
		end
		vim.fn.chansend(state.terminal_id, { cmd .. "\r\n" })
	end

	---wait for 3 second before sending the command if created_newly
	if created_newly then
		vim.defer_fn(function()
			send()
		end, 3000)
		return
	else
		send()
	end
end

M.create_command = require("terminal.command").create_command

return M
