-- Periodically check for external changes every 5 seconds
local function checktime_periodically()
	vim.cmd("checktime")
	vim.defer_fn(checktime_periodically, 2000) -- Re-run every 10 seconds
end

checktime_periodically()
