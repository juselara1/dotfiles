local fn = require("functions")

---Component for spacing.
---@param n_spaces integer # Number of spaces.
---@return string # Spaces.
local function statusline_spaces(n_spaces)
	local spaces = ""
	for _ = 1, n_spaces do
		spaces = spaces .. " "
	end
	return spaces
end

---Component that displays the current git branch.
---@return string # Git branch.
local function statusline_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return (" %s"):format(branch)
	else
		return branch
	end
end

---Component that displays the filetype icon.
---@return string # Filetype icon
local function statusline_filetype()
	local ft = vim.bo.filetype
	local icons = {
		lua = "",
		python = "",
		c = "",
		cpp = "",
		json = "",
		markdown = "",
		javascript = "",
		html = "",
		css = "",
		vim = "",
		sh = "",
		rust = "",
		yaml = "",
		toml = "",
		make = "",
	}
	if ft == "" then
		return ""
	end
	return icons[ft]
end

---Component that displays the filename.
---@return string # Filename.
local function statusline_filename()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return ("%s"):format(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))
	else
		return "[No Name]"
	end
end

---Convert mode to human readable text.
---@param mode string # Vim mode.
---@return string # Human-readable mode.
local function mode_to_readable(mode)
	if fn.in_table({ "n", "no" }, mode) then
		return "λ Normal "
	elseif fn.in_table({ "R", "Rv" }, mode) then
		return "ω Replace"
	elseif fn.in_table({ "s", "S", "\x13" }, mode) then
		return "Γ Select "
	elseif fn.in_table({ "c", "cv", "ce" }, mode) then
		return "π Command"
	elseif fn.in_table({ "r", "rm", "r?" }, mode) then
		return "σ Prompt "
	elseif "v" == mode then
		return "β Visual "
	elseif "V" == mode then
		return "β VisualL"
	elseif "\x16" == mode then
		return "α Insert "
	elseif "i" == mode then
		return "α Insert "
	elseif "t" == mode then
		return "Φ Term   "
	else
		return mode
	end
end

---Component that displays the current vim mode.
---@return string # Filetype icon
local function statusline_mode()
	return ("%s"):format(mode_to_readable(vim.fn.mode()))
end

---Component that displays if the buffer has been modified.
---@return Component # Modified buffer.
local function statusline_modified()
	if vim.bo.modified then
		return "●"
	else
		return ""
	end
end

---Component that displays the progress percentage.
---@return string # Progress.
local function statusline_progressbar()
	local bar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
	local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
	return bar[math.ceil(prop * #bar)]
end

---Component that displays a progress bar.
---@return string # Progress bar.
local function statusline_progress()
	local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
	return ("%d %%"):format(math.ceil(prop * 100))
end

_G.statusline_spaces = statusline_spaces
_G.statusline_mode = statusline_mode
_G.statusline_branch = statusline_branch
_G.statusline_filetype = statusline_filetype
_G.statusline_filename = statusline_filename
_G.statusline_modified = statusline_modified
_G.statusline_progressbar = statusline_progressbar
_G.statusline_progress = statusline_progress

---Setups the statusline
local function setup_statusline()
	local group = vim.api.nvim_create_augroup("StatusLine", {})
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#BCBCBC", bg = "#585858" })
	vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#5FAF5F", bg = "#585858" })
	vim.api.nvim_set_hl(0, "StatusLineBranch", { fg = "#AF87AF", bg = "#585858" })
	vim.api.nvim_set_hl(0, "StatusLineModified", { fg = "#AF5F5F", bg = "#585858" })
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		group = group,
		desc = "Sets the statusline.",
		callback = function(_)
			vim.opt_local.statusline = table.concat({
				"%#StatusLineMode#",
				"%{v:lua.statusline_spaces(3)}",
				"%{v:lua.statusline_mode()}",
				"%{v:lua.statusline_spaces(2)}",
				"%#StatusLineBranch#",
				"%{v:lua.statusline_branch()}",
				"%{v:lua.statusline_spaces(3)}",
				"%#StatusLine#",
				"%{v:lua.statusline_filetype()}",
				"%{v:lua.statusline_spaces(1)}",
				"%{v:lua.statusline_filename()}",
				"%{v:lua.statusline_spaces(1)}",
				"%#StatusLineModified#",
				"%{v:lua.statusline_modified()}",
				"%#StatusLine#",
				"%=",
				"%{v:lua.statusline_progress()}",
				"%{v:lua.statusline_spaces(1)}",
				"%{v:lua.statusline_progressbar()}",
				"%{v:lua.statusline_spaces(3)}",
			})
		end,
	})
end

---Main entrypoint.
local function main()
	setup_statusline()
end

main()
