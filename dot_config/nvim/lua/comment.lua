local fn = require("functions")
local logging = require("logging")

---@class CommentConfig # Language specific configuration for comments.
---@field pattern string[] # Pattern to match the files.
---@field comment_regex string # Regex to validate if a line is commented.
---@field comment_token string # Comment token to add.

---@alias RowRange {start_line : integer, end_line : integer} # Row range.

---Extracts the visual selection row range.
---@return RowRange # Extracted selection range.
local function get_selection_range()
	local start_line = vim.fn.line(".")
	local end_line = vim.fn.line("v")
	print(start_line, end_line)
	if end_line < start_line then
		start_line, end_line = end_line, start_line
	end
	return { start_line = start_line, end_line = end_line }
end

---Validates if all lines are commented.
---@param row_range RowRange # Selection range.
---@param config CommentConfig # Comment config.
---@return boolean # Validation.
local function validate_commented_lines(row_range, config)
	local buffer = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buffer, row_range.start_line - 1, row_range.end_line, false)
	local pattern = vim.regex(config.comment_regex)
	return fn.all(fn.map(function(line)
		if #line == 0 then
			return true
		elseif pattern:match_str(line) == nil then
			return false
		else
			return true
		end
	end, lines))
end

---Comments the target lines.
---@param row_range RowRange # Selection range.
---@param config CommentConfig # Comment config.
local function comment_lines(row_range, config)
	vim.cmd(("%d,%dnorm I%s"):format(row_range.start_line, row_range.end_line, config.comment_token))
end

---Uncomment the target lines.
---@param row_range RowRange # Selection range.
---@param config CommentConfig # Comment config.
local function uncomment_lines(row_range, config)
	local comment_token = config.comment_token:gsub("/", "\\/")
	vim.cmd(("%d,%ds/\\v^\\s*\\zs%s\\s*\\ze//"):format(row_range.start_line, row_range.end_line, comment_token))
end

---Smart autocomment on visual selection.
---@config CommentConfig # Comment config.
local function smart_comment(config)
	local row_range = get_selection_range()
	if validate_commented_lines(row_range, config) then
		uncomment_lines(row_range, config)
	else
		comment_lines(row_range, config)
	end
end

---Setup code commenter.
---@param config FormatConfig # Language specific configuration.
---@param group any # Neovim augroup.
local function setup_code_comment_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Sets the code comment shortcuts.",
		pattern = config.pattern,
		callback = function(_)
			logging.info("[comment] Setting up comment.")
			vim.keymap.set("v", "gc", function()
				smart_comment(config)
			end, { silent = true, noremap = true, desc = "[G]o [C]omment" })
		end,
	})
end

---Setups comment for Lua files.
---@param group any # Neovim augroup.
local function setup_lua(group)
	local config = {
		pattern = { "*.lua" },
		comment_regex = "\\v^\\s*--",
		comment_token = "-- ",
	}
	setup_code_comment_autocmd(config, group)
end

---Setups comment for Python files.
---@param group any # Neovim augroup.
local function setup_python(group)
	local config = {
		pattern = { "*.py" },
		comment_regex = "\\v^\\s*#",
		comment_token = "# ",
	}
	setup_code_comment_autocmd(config, group)
end

---Setups comment for C files.
---@param group any # Neovim augroup.
local function setup_c(group)
	local config = {
		pattern = { "*.c", "*.h" },
		comment_regex = "\\v^\\s*//",
		comment_token = "// "
	}
	setup_code_comment_autocmd(config, group)
end

---Main entrypoint.
local function main()
	local group = vim.api.nvim_create_augroup("CodeComment", {})
	setup_lua(group)
	setup_python(group)
	setup_c(group)
end

main()
