local fn = require("functions")

---@alias InitFn fun(table): nil
---@alias ProviderFn fun(table): nil
---@alias Hl {fg: string | nil, bg: string | nil, bold: boolean | nil}
---@alias HlFn fun(table): Hl
---@alias Component {init: InitFn | nil, provider: ProviderFn | str, hl: HlFn | Hl, update: table}

local Colors = {
	bg = "#2D353B",
	fg = "#D3C6AA",
	black = "#475258",
	red = "#E67E80",
	green = "#A7C080",
	yellow = "#DBBC7F",
	blue = "#7FBBB3",
	magenta = "#D699B6",
	cyan = "#83C092",
	white = "#D3C6AA",
}

---Factory for spaces component.
---@param n_spaces integer # Number of spaces to add.
---@return Component # Spaces component.
local function space(n_spaces)
	local spaces = ""
	for _ = 1, n_spaces do
		spaces = spaces .. " "
	end
	return {
		provider = spaces,
		hl = { bg = "" },
	}
end

---Convert mode to human readable text.
---@param mode string # Vim mode.
---@return string # Human-readable mode.
local function mode_to_readable(mode)
	if fn.in_table({ "n", "no" }, mode) then
		return " λ Normal  "
	elseif fn.in_table({ "R", "Rv" }, mode) then
		return " ω Replace "
	elseif fn.in_table({ "s", "S", "\x13" }, mode) then
		return " Γ Select  "
	elseif fn.in_table({ "c", "cv", "ce" }, mode) then
		return " π Command "
	elseif fn.in_table({ "r", "rm", "r?" }, mode) then
		return " σ Prompt  "
	elseif "v" == mode then
		return " β Visual  "
	elseif "V" == mode then
		return " β VisualL "
	elseif "\x16" == mode then
		return " α Insert  "
	elseif "i" == mode then
		return " α Insert  "
	elseif "t" == mode then
		return " Φ Term    "
	else
		return mode
	end
end

---Convert mode to human readable text.
---@param mode string # Vim mode.
---@return string # Human-readable mode.
local function mode_colorizer(mode)
	if fn.in_table({ "n", "no" }, mode) then
		return Colors.green
	elseif fn.in_table({ "R", "Rv" }, mode) then
		return Colors.red
	elseif fn.in_table({ "s", "S", "\x13" }, mode) then
		return Colors.cyan
	elseif fn.in_table({ "c", "cv", "ce" }, mode) then
		return Colors.yellow
	elseif fn.in_table({ "r", "rm", "r?" }, mode) then
		return Colors.red
	elseif "v" == mode then
		return Colors.blue
	elseif "V" == mode then
		return Colors.blue
	elseif "\x16" == mode then
		return Colors.cyan
	elseif "i" == mode then
		return Colors.cyan
	elseif "t" == mode then
		return Colors.magenta
	else
		return Colors.bg
	end
end

---Factory for vi mode.
---@return Component # Vi mode component.
local function vi_mode()
	return {
		provider = function(_)
			return mode_to_readable(vim.fn.mode())
		end,
		hl = function(_)
			return { fg = Colors.bg, bg = mode_colorizer(vim.fn.mode()), bold = true }
		end,
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		},
	}
end

---Factory for git branch.
---@return Component # Git branch component.
local function git_branch()
	return {
		provider = function(_)
			local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
			if branch ~= "" then
				return (" %s"):format(branch)
			else
				return branch
			end
		end,
		hl = { fg = Colors.magenta },
	}
end

---Factory for filetype.
---@return Component # Filetype component.
local function filetype()
	return {
		provider = function(_)
			local icons = require("mini.icons")
			local ft = vim.bo.filetype
			local icon, _, _ = icons.get("filetype", ft)
			return icon
		end,
		hl = { fg = Colors.fg },
	}
end

---Factory for filename.
---@return Component # Filename component.
local function filename()
	return {
		provider = function()
			if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
				return ("%s"):format(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))
			else
				return "[No Name]"
			end
		end,
		hl = { fg = Colors.fg },
	}
end

---Factory for buffer modified.
---@return Component # Buffer modified component.
local function buffer_modified()
	return {
		provider = function()
			if vim.bo.modified then
				return "●"
			else
				return ""
			end
		end,
		hl = { fg = Colors.red },
	}
end

---Factory for align.
---@return Component # Align component.
local function align()
	return {
		provider = "%=",
		hl = { bg = "" },
	}
end

---Factory for progress.
---@return Component # Progress component.
local function progress()
	return {
		provider = function()
			local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
			return ("%d"):format(math.ceil(prop * 100)) .. " %%"
		end,
		hl = { fg = Colors.fg },
	}
end

---Factory for progress bar.
---@return Component # Progress bar component.
local function progress_bar()
	return {
		provider = function()
			local bar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
			local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
			return bar[math.ceil(prop * #bar)]
		end,
		hl = { fg = Colors.blue },
	}
end

return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		require("heirline").setup({
			statusline = {
				space(3),
				vi_mode(),
				space(2),
				git_branch(),
				align(),
				filetype(),
				space(1),
				filename(),
				space(1),
				buffer_modified(),
				align(),
				progress(),
				space(1),
				progress_bar(),
				space(3),
			},
		})
	end,
}
