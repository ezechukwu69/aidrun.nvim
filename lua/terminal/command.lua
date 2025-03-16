local M = {}

---@param field any
---@param cmd string
---@param option string
---@param value string
---@param is_string? boolean
---@return string
local append_option = function(field, cmd, option, value, is_string)
	if not field then
		return cmd
	end

	if is_string and value == "" then
		return cmd
	end

	if option ~= "" then
		cmd = cmd .. " " .. option
	end
	if value ~= "" then
		cmd = cmd .. " " .. value
	end
	return cmd
end

---@return string
M.create_command = function()
	local cmd = "aider"
	---@type Config
	local config = require("terminal").state.config
	local auto_lint = ""
	if config.options.auto_lint then
		auto_lint = "--auto-lint"
	else
		auto_lint = "--no-auto-lint"
	end
	cmd = append_option(config.options.model, cmd, "--model", config.options.model, true)
	cmd = append_option(config.options.watch, cmd, "--watch-files", "")
	cmd = append_option(config.options.architect, cmd, "--architect", "")
	cmd = append_option(config.options.vim, cmd, "--vim", "")
	cmd = append_option(config.options.auto_lint, cmd, auto_lint, "")
	cmd = append_option(config.options.browser, cmd, "--browser", "")
	cmd = append_option(config.options.weak_model, cmd, "--weak-model", config.options.weak_model, true)
	cmd = append_option(config.options.editor_model, cmd, "--editor-model", config.options.weak_model, true)
	cmd = append_option(
		config.options.editor_edit_format,
		cmd,
		"--editor-edit-format",
		config.options.editor_edit_format,
		true
	)
	cmd = append_option(config.options.edit_format, cmd, "--edit-format", config.options.edit_format, true)
	cmd =
		append_option(config.options.show_model_warnings, cmd, "--show-model-warnings", config.options.weak_model, true)
	cmd = append_option(config.options.dark_mode, cmd, "--dark-mode", "")
	cmd = append_option(config.options.show_diffs, cmd, "--show-diffs", "")
	cmd = append_option(config.options.auto_commits_disabled, cmd, "--no-auto-commits", "")
	cmd = append_option(config.options.attribute_author_disabled, cmd, "--no-attribute-author", "")
	cmd = append_option(config.options.attribute_committer_disabled, cmd, "--no-attribute-committer", "")
	cmd = append_option(
		config.options.attribute_commit_message_author_disabled,
		cmd,
		"--no-attribute-commit-message-author",
		""
	)
	cmd = append_option(
		config.options.attribute_commit_message_committer_disabled,
		cmd,
		"--no-attribute-commit-message-committer",
		""
	)
	for _, arg in ipairs(config.options.additional_args) do
		cmd = cmd .. " " .. arg
	end
	return cmd
end

return M
