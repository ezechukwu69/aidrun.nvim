---@class Config
---@field width? number
---@field options ConfigOps

---@class ConfigOps
---@field watch boolean
---@field architect boolean
---@field weak_model string
---@field model string
---@field auto_lint? boolean
---@field editor_model string
---@field editor_edit_format string
---@field show_model_warnings boolean
---@field dark_mode boolean
---@field show_diffs boolean
---@field vim? boolean
---@field browser? boolean
---@field edit_format? "whole" | "diff" | "diff-fenced" | "udiff"
---@field auto_commits_disabled boolean
---@field attribute_author_disabled boolean
---@field attribute_committer_disabled boolean
---@field attribute_commit_message_author_disabled boolean
---@field attribute_commit_message_committer_disabled boolean
---@field additional_args string[]

local M = {}

---@type Config
M.config = {
	-- Your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	width = 0.3,
	options = {
		watch = true,
		architect = true,
		weak_model = "",
		editor_model = "",
		edit_format = nil,
		model = "",
		auto_lint = false,
		vim = false,
		browser = false,
		editor_edit_format = "",
		show_model_warnings = true,
		dark_mode = true,
		show_diffs = true,
		auto_commits_disabled = true,
		attribute_author_disabled = true,
		attribute_committer_disabled = true,
		attribute_commit_message_author_disabled = true,
		attribute_commit_message_committer_disabled = true,
		additional_args = {},
	},
}

return M
