local M = {}

---Shows an info message.
---@param message string # Message to display.
function M.info(message)
	vim.api.nvim_echo({{message, "MoreMsg"}}, true, {})
end

---Shows a warning message.
---@param message string # Message to display.
function M.warning(message)
	vim.api.nvim_echo({{message, "WarningMsg"}}, true, {})
end

---Shows an error message.
---@param message string # Message to display.
function M.error(message)
	vim.api.nvim_echo({{message, "ErrorMsg"}}, true, {})
end

return M
