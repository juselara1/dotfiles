local F = require("functions")

local Colors = {
	bg = "#1F1F28",
	fg = "#DCD7BA",
	yellow = "#C0A36E",
	cyan = "#6A9589",
	green = "#76976A",
	orange = "#FF8800",
	violet = "#A9A1E1",
	magenta = "#957FB8",
	blue = "#7E9CD8",
	red = "#C34043",
	white = "#C8C093",
}

local ModeColorMapping = {
	n = Colors.red,
	no = Colors.red,
	i = Colors.green,
	v = Colors.blue,
	V = Colors.blue,
	["\x16"] = Colors.blue,
	c = Colors.magenta,
	cv = Colors.magenta,
	ce = Colors.magenta,
	s = Colors.orange,
	S = Colors.orange,
	["\x13"] = Colors.orange,
	R = Colors.violet,
	Rv = Colors.violet,
	r = Colors.cyan,
	["r?"] = Colors.cyan,
	t = Colors.white,
}

---Convert mode to human readable text.
---@param mode string # Vim mode.
---@return string # Human-readable mode.
local function mode_to_readable(mode)
	if F.in_table({ "n", "no" }, mode) then
		return "λ Normal "
	elseif F.in_table({ "R", "Rv" }, mode) then
		return "ω Replace"
	elseif F.in_table({ "s", "S", "\x13" }, mode) then
		return "Γ Select "
	elseif F.in_table({ "c", "cv", "ce" }, mode) then
		return "π Command"
	elseif F.in_table({ "r", "rm", "r?" }, mode) then
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

---@alias Component {[1]: string | fun(): string, color: table, padding: table} # Lualine component.

---Adds a vline ascii character.
---@return Component # Vertical line.
local function vline()
	return {
		function()
			return "▊"
		end,
		color = { fg = Colors.blue },
		padding = { left = 0, right = 0 },
	}
end

---Displays the current vim mode.
---@return Component # Vim mode.
local function mode_component()
	return {
		function()
			return mode_to_readable(vim.fn.mode())
		end,
		color = function()
			return {
				fg = Colors.bg,
				bg = ModeColorMapping[vim.fn.mode()],
				gui = "bold",
			}
		end,
		padding = { right = 1, left = 1 },
	}
end

---Displays the git branch.
---@return Component
local function branch_component()
	return {
		"branch",
		color = { fg = Colors.magenta },
	}
end

---Displays the filetype as an icon.
---@param icons any # Module to collect icons.
---@return Component # Filetype.
local function filetype_component(icons)
	return {
		function()
			local icon = icons.get_icon(vim.fn.expand("%:t"))
			if icon == nil then
				return ""
			else
				return icon
			end
		end,
		color = { fg = Colors.fg },
	}
end

---Displays the filename.
---@return Component # Filename.
local function filename_component()
	return {
		function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
		end,
		cond = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		color = { fg = Colors.fg },
	}
end

---Displays if the buffer has been modified.
---@return Component # Modified buffer
local function modified_buffer_component()
	return {
		function()
			return "●"
		end,
		cond = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		color = function()
			if vim.bo.modified then
				return { fg = Colors.red }
			else
				return { fg = Colors.green }
			end
		end,
	}
end

---Displays the search count
---@return Component # Search count.
local function search_count_component()
	return {
		"searchcount",
		color = { fg = Colors.yellow },
		padding = { left = 1, right = 1 },
	}
end

---Displays a progress bar.
---@return Component # Progress bar.
local function progress_bar_component()
	return {
		function()
			local bar = {"▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"}
			local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
			return bar[math.ceil(prop * #bar)]
		end,
		color = {fg = Colors.fg},
		padding = {left = 1, right = 1}
	}
end

---Displays the lines as a progress percentage.
---@return Component # Line progress.
local function progress_component()
	return {
		"progress",
		color = { fg = Colors.fg },
		padding = { left = 1, right = 1 },
	}
end

---Displays when macros are being recorded.
---@return Component # Recording macro.
local function recording_macro_component()
	return {
		function()
			local reg = vim.fn.reg_recording()
			return ("Recording %s"):format(reg)
		end,
		color = { fg = Colors.fg, bg = Colors.red, gui = "bold" },
		cond = function()
			return vim.fn.reg_recording() ~= ""
		end,
	}
end

---Setups the lualine statusline.
local function setup()
	local lualine = require("lualine")
	local icons = require("nvim-web-devicons")
	lualine.setup({
		options = {
			component_separators = "",
			section_separators = "",
			theme = {
				normal = { c = { fg = Colors.fg, bg = Colors.bg } },
				inactive = { c = { fg = Colors.fg, bg = Colors.bg } },
			},
		},
		sections = {
			lualine_a = { vline() },
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {
				mode_component(),
				branch_component(),
				filetype_component(icons),
				filename_component(),
				modified_buffer_component(),
				recording_macro_component(),
			},
			lualine_x = {
				search_count_component(),
				progress_bar_component(),
				progress_component(),
				vline(),
			},
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = setup,
}
