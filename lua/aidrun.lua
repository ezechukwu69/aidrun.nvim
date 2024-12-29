local M = {}

---@param opts Config - Configuration options for setting up the plugin.
function M.setup(opts)
	-- Extend the provided options with default configuration and merge them into a single table.
	opts = vim.tbl_deep_extend("force", require("config").config, opts or {}, opts or {})

	-- Set up commands using the provided options.
	require("commands").setup(opts)

	-- Load general options.
	require("options")

	-- Load cron-related options.
	require("options.cron")

	-- Load autocommands-related options.
	require("options.autocommands")
end

return M
